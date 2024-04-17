//
//  UserDefaultsService.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 16.10.23.
//

import Foundation

import Foundation

class UserDefaultsService {
    private static let deviceIdKey = "deviceId"
    private static let successKey = "success"
    private static let fabricId = "fabricId"

    let group: UserDefaults

    init(appGroup: String) {
        group = UserDefaults(suiteName: appGroup)!
    }

    func data(forKey key: String) -> Data? {
        return group.data(forKey: key)
    }

    func set(_ value: Data, forKey key: String) {
        group.set(value, forKey: key)
    }

    func removeObject(forKey key: String) {
        group.removeObject(forKey: key)
    }

    func setDeviceId(_ deviceId: Int64) {
        group.set(deviceId, forKey: UserDefaultsService.deviceIdKey)
    }

    func getDeviceId() -> Int64? {
        return group.object(forKey: UserDefaultsService.deviceIdKey) as? Int64
    }

    func resetSuccess() {
        group.removeObject(forKey: UserDefaultsService.successKey)
    }

    func setSuccess() {
        group.set(true, forKey: UserDefaultsService.successKey)
    }

    func success() -> Bool {
        return group.bool(forKey: UserDefaultsService.successKey)
    }
}
