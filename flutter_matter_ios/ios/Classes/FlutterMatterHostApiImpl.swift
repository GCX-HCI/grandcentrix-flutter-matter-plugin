//
//  FlutterMatterHostApiImpl.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 08.09.23.
//

import Foundation
import OSLog
import MatterSupport
import Matter
import Flutter

// This extension of Error is required to do use FlutterError in any Swift code.
extension FlutterError: Error {}

class FlutterMatterHostApiImpl : FlutterMatterHostApi
{
    // MARK: FlutterMatterHostApi Methods
    
    func getPlatformVersion(completion: @escaping (Result<String, Error>) -> Void) {
        completion(Result.success("iOS " + UIDevice.current.systemVersion))
    }
    
    func commission(request: CommissionRequest, completion: @escaping (Result<MatterDevice, Error>) -> Void) {
        Task {
            os_log(.default, "Starting to add device...")
            
            let topology = MatterAddDeviceRequest.Topology(ecosystemName: "MyEcosystemName", homes: [])
            
            let matterDeviceRequest = MatterAddDeviceRequest(topology: topology)
            
            UserDefaults.resetSuccess()
            UserDefaults.setDeviceId(request.id)
            
            do {
                try await matterDeviceRequest.perform()
                
                if(!UserDefaults.success())
                {
                    os_log(.default, "User cancelled")
                    completion(Result.failure(FlutterError(code: "-3", message: "User cancelled", details: nil)))
                    return
                }
                
                os_log(.default, "Successfully set up device!")
                completion(Result.success(MatterDevice(id: request.id)))
            }
            catch {
                os_log(.error, "Failed to set up device with error: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to set up device", details: nil)))
            }
        }
    }
    
    func unpair(deviceId: Int64, completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                let controller = try MTRDeviceController.shared()
                let device = MTRBaseDevice(nodeID: NSNumber(value: deviceId), controller: controller)
                
                let opCredsCluster = MTRBaseClusterOperationalCredentials(device: device, endpointID: 0, queue: DispatchQueue.main)
                
                let fabricIndex = try await opCredsCluster!.readAttributeCurrentFabricIndex()
                
                let params = MTROperationalCredentialsClusterRemoveFabricParams()
                params.fabricIndex = fabricIndex
                
                try await opCredsCluster!.removeFabric(with: params)
                completion(Result.success(Void()))
            } catch
            {
                os_log(.default, "Failed to unpair device: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to unpair device", details: nil)))
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
                
                completion(Result.success(OpenPairingWindowResult(manualPairingCode: manualPairingCode, qrCode: qrcode)))
            } catch
            {
                os_log(.default, "Failed to openPairingWindowWithPin for device: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to openPairingWindowWithPin for device", details: nil)))
                return
            }
        }
    }
    
    func command(deviceId: Int64, endpointId: Int64, cluster: Cluster, command: Command, completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                let controller = try MTRDeviceController.shared()
                let device = MTRBaseDevice(nodeID: NSNumber(value: deviceId), controller: controller)
                var commandHandler: CommandHandler?
                
                switch cluster {
                case Cluster.onOff:
                    commandHandler = OnOffCommandHandler(device)
                    break
                default:
                    completion(Result.failure(FlutterError(code: "-4", message: "Cluster not implemented", details: nil)))
                    return
                }
                
                try await commandHandler!.handle(command, deviceId: deviceId, endpointId: endpointId)
                completion(Result.success(Void()))
            } catch FlutterMatterError.CommandNotImplemented {
                completion(Result.failure(FlutterError(code: "-5", message: "Command not implemented", details: nil)))
                return
            }
            catch
            {
                os_log(.default, "Failed to send command to device: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to send command to device", details: nil)))
                return
            }
        }
    }
}
