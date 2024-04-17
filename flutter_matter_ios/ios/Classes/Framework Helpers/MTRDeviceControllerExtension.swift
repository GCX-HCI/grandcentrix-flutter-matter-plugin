//
//  MTRDeviceControllerExtension.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 02.10.23.
//

import Foundation
import Matter
import OSLog

extension MTRDeviceController {
    private static var instance: MTRDeviceController?

    public static func shared() throws -> MTRDeviceController {
        if instance != nil {
            return instance!
        }

        let storage = MTRStorageImpl.getInstance()
        let deviceControllerFactoryParams = MTRDeviceControllerFactoryParams(storage: storage)
        let deviceControllerFactory = MTRDeviceControllerFactory.sharedInstance()
        try deviceControllerFactory.start(deviceControllerFactoryParams)

        let keyPair = MTRKeypairImpl()

        let deviceControllerStartupParams = MTRDeviceControllerStartupParams(ipk: keyPair.ipk!, fabricID: 1, nocSigner: keyPair)
        deviceControllerStartupParams.vendorID = 0xFFF1 // TODO: Read vom UserDefaults

        do {
            // Create a MTRDeviceController on an existing fabric. Returns nil on failure.
            // This method will fail if there is no such fabric or if there is already a controller started for that fabric.
            instance = try deviceControllerFactory.createController(onExistingFabric: deviceControllerStartupParams)
        } catch {
            os_log(.default, "Device Controller doesn't exists for fabric, so creating a new one!")
            // This method will fail if the given fabric already exists.
            instance = try deviceControllerFactory.createController(onNewFabric: deviceControllerStartupParams)
        }

        return instance!
    }
}
