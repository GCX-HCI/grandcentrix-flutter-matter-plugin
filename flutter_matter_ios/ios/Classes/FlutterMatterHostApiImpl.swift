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

extension UserDefaults {
    private static let deviceIdKey = "deviceId"
    private static let successKey = "success"
    private static let group = UserDefaults(suiteName: "group.example.flutterMatterIosExample")!
    
    static func setDeviceId(_ deviceId: Int64) -> Void {
        UserDefaults.group.set(deviceId, forKey: UserDefaults.deviceIdKey)
    }
    
    static func getDeviceId() -> Int64? {
        return UserDefaults.group.object(forKey: UserDefaults.deviceIdKey) as? Int64
    }
    
    static func resetSuccess() -> Void {
        UserDefaults.group.removeObject(forKey: UserDefaults.successKey)
    }
    
    static func setSuccess() -> Void {
        UserDefaults.group.set(true, forKey: UserDefaults.successKey)
    }
    
    static func success() -> Bool {
        return UserDefaults.group.bool(forKey: UserDefaults.successKey)
    }
}

class FlutterMatterHostApiImpl : FlutterMatterHostApi
{
    
    // MARK: FlutterMatterHostApi Methods
    
    func getPlatformVersion(completion: @escaping (Result<String, Error>) -> Void) {
        completion(Result.success("iOS " + UIDevice.current.systemVersion))
    }
    
    func commission(request: CommissionRequest, completion: @escaping (Result<MatterDevice, Error>) -> Void) {
        Task {
            os_log(.default, "Starting to add device...")
            
            //let homes = [MatterAddDeviceRequest.Home(displayName: "My Home")]
            //let topology = MatterAddDeviceRequest.Topology(ecosystemName: "MyEcosystemName", homes: homes)
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
}
