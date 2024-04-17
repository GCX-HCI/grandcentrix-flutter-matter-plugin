//
//  MTRKeypairImpl.swift
//  FlutterMatterExtension
//
//  Created by Philipp Manstein on 14.09.23.
//

import Foundation
import Matter
import OSLog
import Security

extension Data {
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type _: T.Type) -> T {
        return withUnsafeBytes { $0.load(as: T.self) }
    }
}

class MTRKeypairImpl: NSObject, MTRKeypair {
    static let MTRIPKKeyChainLabel = "matter-tool.nodeopcerts.IPK:0"
    static let MTRCAKeyChainLabel = "matter-tool.nodeopcerts.CA:0"

    public var ipk: Data?
    public var privateKey: SecKey?

    override public init() {
        super.init()

        ipk = loadIpk()
        if ipk == nil {
            ipk = generateIpk()
        }

        privateKey = loadCAPrivateKey()
        if privateKey == nil {
            privateKey = generateCAPrivateKey()
        }

        os_log(.default, "ipk: %{public}@", String(describing: ipk))
        os_log(.default, "privateKey: %{public}@", String(describing: privateKey))
    }

    func publicKey() -> Unmanaged<SecKey> {
        let publicKey = SecKeyCopyPublicKey(privateKey!)
        return Unmanaged<SecKey>.passRetained(publicKey!).autorelease()
    }

    func signMessageECDSA_DER(_ message: Data) -> Data {
        let outData = SecKeyCreateSignature(privateKey!, SecKeyAlgorithm.ecdsaSignatureMessageX962SHA256, message as CFData, nil)
        if outData == nil { // TODO: Check for error!
            return Data()
        }

        return outData! as Data
    }

    func loadIpk() -> Data? {
        os_log(.default, "loadIpk called")

        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationLabel as String: MTRKeypairImpl.MTRIPKKeyChainLabel,
            kSecAttrKeyClass as String: kSecAttrKeyClassSymmetric,
            kSecReturnData as String: kCFBooleanTrue!,
        ]

        // The CFDataRef we get from SecItemCopyMatching allocates its buffer in a
        // way that zeroes it when deallocated.
        var dataTypeRef: AnyObject? = nil

        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status != noErr {
            os_log(.default, "SecItemCopyMatching failed")
            return nil
        }

        os_log(.default, "SecItemCopyMatching success")
        return (dataTypeRef as? Data)
    }

    func generateIpk() -> Data? {
        os_log(.default, "generateIpk called")

        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationLabel as String: MTRKeypairImpl.MTRIPKKeyChainLabel,
            kSecAttrKeyClass as String: kSecAttrKeyClassSymmetric,
        ]

        // First, delete any existing item, since otherwise trying to add the new item
        // later will fail.  Ignore delete failure, since we might not have had the
        // item at all.
        SecItemDelete(deleteQuery as CFDictionary)

        // Generate an IPK.  For now, hardcoded to 16 bytes until the
        // framework exposes this constant.
        let ipk_size = 16
        var ipkData = Data(count: ipk_size)

        let status = ipkData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, ipk_size, $0.baseAddress!)
        }

        if status != noErr {
            os_log(.default, "SecRandomCopyBytes failed")
            return nil
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationLabel as String: MTRKeypairImpl.MTRIPKKeyChainLabel,
            kSecAttrKeyClass as String: kSecAttrKeyClassSymmetric,
            kSecValueData as String: ipkData,
        ]

        let addStatus = SecItemAdd(query as CFDictionary, nil)

        if addStatus != noErr {
            os_log(.default, "SecItemAdd failed")
            if let error: String = SecCopyErrorMessageString(addStatus, nil) as String? {
                os_log(.default, "Error: %{public}@", error)
            }
            return nil
        }

        os_log(.default, "SecItemAdd success")

        return ipkData
    }

    func loadCAPrivateKey() -> SecKey? {
        os_log(.default, "loadCAPrivateKey called")
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationLabel as String: MTRKeypairImpl.MTRCAKeyChainLabel,
            // We're storing a base-64 encoding of some opaque thing that represents
            // our keypair.  It's not really a public or private key; claim it's a
            kSecAttrKeyClass as String: kSecAttrKeyClassSymmetric,
            kSecReturnData as String: kCFBooleanTrue!,
        ] as [String: Any]

        // The CFDataRef we get from SecItemCopyMatching allocates its buffer in a
        // way that zeroes it when deallocated.
        var dataTypeRef: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status != noErr {
            os_log(.default, "SecItemCopyMatching failed")
            return nil
        }

        let createQuery: [String: Any] = [
            kSecAttrKeyClass as String: kSecAttrKeyClassPrivate,
            kSecAttrKeyType as String: kSecAttrKeyTypeECSECPrimeRandom,
            // For now harcoded to 256 bits until the framework exposes this constant./
            kSecAttrKeySizeInBits as String: 256,
            kSecAttrIsPermanent as String: kCFBooleanFalse!,
        ]

        let key = SecKeyCreateWithData(dataTypeRef as! CFData, createQuery as CFDictionary, nil)
        if key == nil {
            os_log(.default, "SecKeyCreateWithData failed")
            return nil
        }

        return key
    }

    func generateCAPrivateKey() -> SecKey? {
        os_log(.default, "generateCAPrivateKey called")
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationLabel as String: MTRKeypairImpl.MTRCAKeyChainLabel,
            // We're storing a base-64 encoding of some opaque thing that represents
            // our keypair.  It's not really a public or private key; claim it's a
            kSecAttrKeyClass as String: kSecAttrKeyClassSymmetric,
        ]
        // First, delete any existing item, since otherwise trying to add the new item
        // later will fail.  Ignore delete failure, since we might not have had the
        // item at all.
        SecItemDelete(deleteQuery as CFDictionary)

        let createQuery: [String: Any] = [
            kSecAttrKeyClass as String: kSecAttrKeyClassPrivate,
            kSecAttrKeyType as String: kSecAttrKeyTypeECSECPrimeRandom,
            // For now harcoded to 256 bits until the framework exposes this constant./
            kSecAttrKeySizeInBits as String: 256,
            kSecAttrIsPermanent as String: kCFBooleanFalse!,
        ]

        let key = SecKeyCreateRandomKey(createQuery as CFDictionary, nil)
        if key == nil {
            os_log(.default, "SecKeyCreateRandomKey failed")
            return nil
        }

        let keyData = SecKeyCopyExternalRepresentation(key!, nil) as Data?
        if keyData == nil {
            os_log(.default, "SecKeyCopyExternalRepresentation failed")
            return nil
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationLabel as String: MTRKeypairImpl.MTRCAKeyChainLabel,
            // We're storing a base-64 encoding of some opaque thing that represents
            // our keypair.  It's not really a public or private key; claim it's a
            kSecAttrKeyClass as String: kSecAttrKeyClassSymmetric,
            kSecValueData as String: keyData!.base64EncodedData(),
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        if status != noErr {
            os_log(.default, "SecItemAdd failed")
            return nil
        }

        return key
    }
}
