import Flutter
import Foundation
import Matter
import MatterSupport
import OSLog

// This extension of Error is required to do use FlutterError in any Swift code.
extension FlutterError: Error {}

class FlutterMatterHostApiImpl: FlutterMatterHostApi {
    private var userDefaultsService: UserDefaultsService?

    // MARK: FlutterMatterHostApi Methods

    func getPlatformVersion(completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success("iOS " + UIDevice.current.systemVersion))
    }

    func initParams(params: InitParams) throws {
        userDefaultsService = UserDefaultsService(appGroup: params.appGroup)
        MTRStorageImpl.initInstance(withUserDefaultsService: userDefaultsService!)

        guard let userDefaultsService else {
            return
        }

        userDefaultsService.setFabricId(params.fabricId)
        userDefaultsService.setVendorId(params.vendorId)
        MTRDeviceController.setData(fabricID: params.fabricId, vendorID: params.vendorId)
    }

    func commission(request: CommissionRequest, completion: @escaping (Result<MatterDevice, Error>) -> Void) {
        Task {
            os_log(.default, "Starting to add device...")

            guard let userDefaultsService else {
                completion(Result.failure(FlutterError(code: "-1", message: "initParams wasn't called!", details: nil)))
                return
            }

            let topology = MatterAddDeviceRequest.Topology(ecosystemName: request.ecoSystemName, homes: [])

            let matterDeviceRequest = MatterAddDeviceRequest(topology: topology)

            userDefaultsService.resetSuccess()
            userDefaultsService.setDeviceId(request.id)

            do {
                try await matterDeviceRequest.perform()

                guard userDefaultsService.success() else {
                    os_log(.default, "User cancelled")
                    completion(.failure(FlutterError(code: "-3", message: "User cancelled", details: nil)))
                    return
                }

                os_log(.default, "Successfully set up device!")
                completion(.success(MatterDevice(id: request.id)))
            } catch {
                os_log(.error, "Failed to set up device with error: \(error)")
                completion(.failure(FlutterError(code: "-1", message: "Failed to set up device", details: nil)))
            }
        }
    }

    func unpair(deviceId: Int64, completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                let controller = try MTRDeviceController.shared()
                let device = MTRBaseDevice(nodeID: NSNumber(value: deviceId), controller: controller)

                guard let opCredsCluster = MTRBaseClusterOperationalCredentials(device: device, endpointID: 0, queue: DispatchQueue.main) else {
                    os_log(.default, "Failed to init credentials")
                    completion(Result.failure(FlutterError(code: "-1", message: "Failed to init credentials", details: nil)))
                    return
                }

                let fabricIndex = try await opCredsCluster.readAttributeCurrentFabricIndex()

                let params = MTROperationalCredentialsClusterRemoveFabricParams()
                params.fabricIndex = fabricIndex

                try await opCredsCluster.removeFabric(with: params)
                completion(.success(()))
            } catch {
                os_log(.default, "Failed to unpair device: \(error)")
                completion(.failure(FlutterError(code: "-1", message: "Failed to unpair device", details: nil)))
                return
            }
        }
    }

    func openPairingWindowWithPin(deviceId: Int64, duration: Int64, discriminator: Int64, setupPin: Int64, completion: @escaping (Result<OpenPairingWindowResult, Error>) -> Void) {
        Task {
            do {
                let controller = try MTRDeviceController.shared()
                let device = MTRBaseDevice(nodeID: NSNumber(value: deviceId), controller: controller)

                let payload = try await device.openCommissioningWindow(withSetupPasscode: NSNumber(value: setupPin), discriminator: NSNumber(value: discriminator), duration: NSNumber(value: duration), queue: DispatchQueue.main)

                let manualPairingCode = payload.manualEntryCode()
                let qrcode = manualPairingCode != nil ? try payload.qrCodeString() : nil

                completion(.success(OpenPairingWindowResult(manualPairingCode: manualPairingCode, qrCode: qrcode)))
            } catch {
                os_log(.default, "Failed to openPairingWindowWithPin for device: \(error)")
                completion(.failure(FlutterError(code: "-1", message: "Failed to openPairingWindowWithPin for device", details: nil)))
                return
            }
        }
    }
}
