//
//  UserDefaultsExtension.swift
//  FlutterMatterExtension
//
//  Created by Philipp Manstein on 14.09.23.
//

import Foundation

extension UserDefaults {
    private static let deviceIdKey = "deviceId"
    private static let successKey = "success"
    private static let fabricId = "fabricId"
    static let group = UserDefaults(suiteName: "group.example.flutterMatterExample")!
    
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
