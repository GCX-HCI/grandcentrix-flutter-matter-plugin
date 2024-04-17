//
//  MTRStorageImpl.swift
//  FlutterMatterExtension
//
//  Created by Philipp Manstein on 14.09.23.
//

import Foundation
import Matter

class MTRStorageImpl: NSObject, MTRStorage {
    /**
     * Get the data for the given key.  Returns nil if there is no data for the
     * key.
     */
    func storageData(forKey key: String) -> Data? {
        return UserDefaults.group.data(forKey: key)
    }

    /**
     * Set the data for the viven key to the given value.  Returns YES if the key
     * was set successfully, NO otherwise.
     */
    func setStorageData(_ value: Data, forKey key: String) -> Bool {
        UserDefaults.group.set(value, forKey: key)
        return true
    }

    /**
     * Delete the key and corresponding data.  Returns YES if the key was present,
     * NO if the key was not present.
     */
    func removeStorageData(forKey key: String) -> Bool {
        if UserDefaults.group.data(forKey: key) == nil {
            return false
        }

        UserDefaults.group.removeObject(forKey: key)
        return true
    }
}
