import Matter
import MatterSupport
import OSLog
import Security

// The extension is launched in response to `MatterAddDeviceRequest.perform()` and this class is the entry point
// for the extension operations.
class RequestHandler: MatterAddDeviceExtensionRequestHandler {
    // IMPORTANT! Change the paramter appGroup to your App Group! See the README for setup!
    private var userDefaultsService = UserDefaultsService(appGroup: "group.example.flutterMatterExample")

    private var deviceCommissioningCheckedThrowingContinuation: CheckedContinuation<Bool, Error>?

    private var deviceID: Int64 = 0

    override func validateDeviceCredential(_ deviceCredential: MatterAddDeviceExtensionRequestHandler.DeviceCredential) async throws {
        // Use this function to perform additional attestation checks if that is useful for your ecosystem.
        os_log(.default, "Received request to validate device credential: %{public}@", String(describing: deviceCredential))
    }

    override func selectWiFiNetwork(from wifiScanResults: [MatterAddDeviceExtensionRequestHandler.WiFiScanResult]) async throws -> MatterAddDeviceExtensionRequestHandler.WiFiNetworkAssociation {
        // Use this function to select a Wi-Fi network for the device if your ecosystem has special requirements.
        // Or, return `.defaultSystemNetwork` to use the iOS device's current network.

        os_log(.default, "Received WiFi scan results: %{public}@", String(describing: wifiScanResults))

        return .defaultSystemNetwork
    }

    override func selectThreadNetwork(from threadScanResults: [MatterAddDeviceExtensionRequestHandler.ThreadScanResult]) async throws -> MatterAddDeviceExtensionRequestHandler.ThreadNetworkAssociation {
        // Use this function to select a Thread network for the device if your ecosystem has special requirements.
        // Or, return `.defaultSystemNetwork` to use the default Thread network.

        os_log(.default, "Received Thread scan results: %{public}@", String(describing: threadScanResults))

        return .defaultSystemNetwork
    }

    override func commissionDevice(in home: MatterAddDeviceRequest.Home?, onboardingPayload: String, commissioningID: UUID) async throws {
        // Use this function to commission the device with your Matter stack.

        os_log(.default, "Received request to commission device in home %{public}@ using onboarding payload: %{public}@ and uuid: %{public}@", String(describing: home), onboardingPayload, String(describing: commissioningID))

        let _ = try await withCheckedThrowingContinuation { [weak self] (continuation: CheckedContinuation<Bool, Error>) in
            guard let self = self else {
                return
            }

            self.deviceCommissioningCheckedThrowingContinuation = continuation

            do {
                MTRStorageImpl.initInstance(withUserDefaultsService: userDefaultsService)
                MTRDeviceController.setData(fabricID: userDefaultsService.getFabricId()!, vendorID: userDefaultsService.getVendorId()!)
                let controller = try MTRDeviceController.shared()
                
                controller.setDeviceControllerDelegate(self, queue: DispatchQueue.main)

                let payload = try MTRSetupPayload(onboardingPayload: onboardingPayload)
                deviceID = userDefaultsService.getDeviceId()!
                try controller.setupCommissioningSession(with: payload, newNodeID: NSNumber(value: deviceID))
            } catch {
                os_log(.error, "Can't start commissionDevice! %{public}@", String(describing: error))
                continuation.resume(throwing: error)
            }
        }

        os_log(.default, "Successfully paired accessory: DeviceID %{public}@", String(describing: deviceID))
        userDefaultsService.setSuccess()
    }

    override func rooms(in home: MatterAddDeviceRequest.Home?) async -> [MatterAddDeviceRequest.Room] {
        // Use this function to return the rooms your ecosystem manages.
        // If your ecosystem manages multiple homes, ensure you are returning rooms that belong to the provided home.

        os_log(.default, "Received request to fetch rooms in home: %{public}@", String(describing: home))
        return []
    }

    override func configureDevice(named name: String, in room: MatterAddDeviceRequest.Room?) async {
        // Use this function to configure the (now) commissioned device with the given name and room.

        os_log(.default, "Received request to configure device with name %{public}@ in room: %{public}@", name, String(describing: room))
    }
}

// MARK: MTRDeviceControllerDelegate

extension RequestHandler: MTRDeviceControllerDelegate {
    func controller(_ controller: MTRDeviceController, commissioningSessionEstablishmentDone error: Error?) {
        if error != nil {
            os_log(.error, "MTRDeviceControllerDelegate: Failed to pair accessory: %{public}@", String(describing: error))
            deviceCommissioningCheckedThrowingContinuation?.resume(throwing: error!)
            deviceCommissioningCheckedThrowingContinuation = nil
            return
        }

        os_log(.default, "MTRDeviceControllerDelegate: commissioningSessionEstablishmentDone")

        do {
            os_log(.default, "MTRDeviceControllerDelegate: commissionNode with id %{public}@", String(describing: deviceID))

            let device = try controller.deviceBeingCommissioned(withNodeID: NSNumber(value: deviceID))
            os_log(.default, "MTRDeviceControllerDelegate: Device.sessionTransportType %{public}@", String(describing: device.sessionTransportType))

            let commissioningParameters = MTRCommissioningParameters()
            commissioningParameters.deviceAttestationDelegate = self
            commissioningParameters.failSafeTimeout = 600
            os_log(.default, "MTRDeviceControllerDelegate: commissionNode with id %{public}@", String(describing: deviceID))
            try controller.commissionNode(withID: NSNumber(value: deviceID), commissioningParams: commissioningParameters)
        } catch {
            os_log(.error, "MTRDeviceControllerDelegate: Failed to commissionNode: %{public}@", String(describing: error))
            deviceCommissioningCheckedThrowingContinuation?.resume(throwing: error)
            deviceCommissioningCheckedThrowingContinuation = nil
        }
    }

    func controller(_: MTRDeviceController, statusUpdate status: MTRCommissioningStatus) {
        os_log(.default, "MTRDeviceControllerDelegate: Status update: %{public}@", String(describing: status))
    }
}

// MARK: MTRDeviceAttestationDelegate

extension RequestHandler: MTRDeviceAttestationDelegate {
    func deviceAttestationCompleted(for controller: MTRDeviceController, opaqueDeviceHandle: UnsafeMutableRawPointer, attestationDeviceInfo: MTRDeviceAttestationDeviceInfo, error: Error?) {
        os_log(.default, "MTRDeviceAttestationDelegate: deviceAttestationCompleted: %{public}@ - Error: %{public}@", String(describing: attestationDeviceInfo), String(describing: error))

        do {
            try controller.continueCommissioningDevice(opaqueDeviceHandle, ignoreAttestationFailure: false)
        } catch {
            deviceCommissioningCheckedThrowingContinuation?.resume(throwing: error)
            deviceCommissioningCheckedThrowingContinuation = nil
            return
        }

        if error == nil {
            deviceCommissioningCheckedThrowingContinuation?.resume(returning: true)
        } else {
            deviceCommissioningCheckedThrowingContinuation?.resume(throwing: error!)
        }

        deviceCommissioningCheckedThrowingContinuation = nil
    }
}
