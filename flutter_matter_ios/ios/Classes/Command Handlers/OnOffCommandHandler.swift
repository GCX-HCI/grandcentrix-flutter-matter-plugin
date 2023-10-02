//
//  OnOffCommandHandler.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 19.09.23.
//

import Foundation
import Matter

class OnOffCommandHandler: CommandHandler {
    private let device: MTRBaseDevice
    
    init(_ device: MTRBaseDevice) {
        self.device = device
    }
    
    func handle(_ command: Command, deviceId: Int64, endpointId: Int64) async throws {
        let onOffCluster = MTRBaseClusterOnOff(device: device, endpointID: NSNumber(value: endpointId), queue: DispatchQueue.main)
        
        switch command {
        case .off:
            try await onOffCluster?.off()
            break
        case .on:
            try await onOffCluster?.on()
            break
        case .toggle:
            try await onOffCluster?.toggle()
            break
        default:
            throw FlutterMatterError.CommandNotImplemented
        }
    }
}
