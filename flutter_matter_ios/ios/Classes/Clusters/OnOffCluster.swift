//
//  OnOffCommandHandler.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 19.09.23.
//

import Foundation
import Matter

class OnOffCluster: CommandHandler, AttributeHandler {
    private let device: MTRBaseDevice
    
    init(_ device: MTRBaseDevice) {
        self.device = device
    }
    
    // MARK: CommandHandler Methods
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
    
    // MARK: CommandHandler Methods
    func handle(_ attribute: Attribute, deviceId: Int64, endpointId: Int64) async throws -> Any {
        let onOffCluster = MTRBaseClusterOnOff(device: device, endpointID: NSNumber(value: endpointId), queue: DispatchQueue.main)
        
        switch attribute {
        case .onOff:
            return try await onOffCluster?.readAttributeOnOff()
        default:
            throw FlutterMatterError.AttributeNotImplemented
        }
    }
}
