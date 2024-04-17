import Foundation
import Matter
import OSLog

class MTRStorageImpl: NSObject, MTRStorage {
    private static var instance: MTRStorageImpl?

    private var userData: UserDefaultsService

    private init(_ userDefaultsService: UserDefaultsService) {
        userData = userDefaultsService
    }

    public static func initInstance(withUserDefaultsService userDefaultsService: UserDefaultsService) {
        if instance != nil {
            os_log(.default, "Already created an instance!")
            return
        }

        instance = MTRStorageImpl(userDefaultsService)
    }

    public static func getInstance() -> MTRStorageImpl {
        return instance!
    }

    /**
     * Get the data for the given key.  Returns nil if there is no data for the
     * key.
     */
    func storageData(forKey key: String) -> Data? {
        return userData.data(forKey: key)
    }

    /**
     * Set the data for the viven key to the given value.  Returns YES if the key
     * was set successfully, NO otherwise.
     */
    func setStorageData(_ value: Data, forKey key: String) -> Bool {
        userData.set(value, forKey: key)
        return true
    }

    /**
     * Delete the key and corresponding data.  Returns YES if the key was present,
     * NO if the key was not present.
     */
    func removeStorageData(forKey key: String) -> Bool {
        if userData.data(forKey: key) == nil {
            return false
        }

        userData.removeObject(forKey: key)
        return true
    }
}
