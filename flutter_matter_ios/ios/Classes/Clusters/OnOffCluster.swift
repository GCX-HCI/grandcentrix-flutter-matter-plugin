//
//  OnOffCommandHandler.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 19.09.23.
//

import Foundation
import OSLog
import Matter
import Flutter

class OnOffCluster: FlutterMatterHostOnOffClusterApi {
    
    private func getCluster(deviceId: Int64, endpointId: Int64) throws -> MTRBaseClusterOnOff {
        let controller = try MTRDeviceController.shared()
        let device = MTRBaseDevice(nodeID: NSNumber(value: deviceId), controller: controller)
        return MTRBaseClusterOnOff(device: device, endpointID: NSNumber(value: endpointId), queue: DispatchQueue.main)!
    }
    
    // MARK: Commands
    
    func off(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                try await cluster.off();
                completion(Result.success(Void()))
            }
            catch {
                os_log(.error, "Failed to send command off: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to send command off", details: nil)))
            }
        }
    }
    
    func on(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<Void, Error>) -> Void)  {
        Task {
            do {
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                try await cluster.on();
                completion(Result.success(Void()))
            }
            catch {
                os_log(.error, "Failed to send command on: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to send command on", details: nil)))
            }
        }
    }
    
    func toggle(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<Void, Error>) -> Void)  {
        Task {
            do {
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                try await cluster.toggle();
                completion(Result.success(Void()))
            }
            catch {
                os_log(.error, "Failed to send command toggle: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to send command toggle", details: nil)))
            }
        }
    }
    
    // MARK: Attributes
    
    func readOnOff(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<Bool, Error>) -> Void)  {
        Task {
            do {
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributeOnOff();
                completion(Result.success(result == 1 ? true : false))
            }
            catch {
                os_log(.error, "Failed to read attribute OnOff: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to read attribute OnOff", details: nil)))
            }
        }
    }
}
