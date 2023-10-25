//
//  TemperatureCluster.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 24.10.23.
//

import Foundation
import OSLog
import Matter
import Flutter

class TemperatureCluster: FlutterMatterHostTemperatureClusterApi {
    
    
    private func getCluster(deviceId: Int64, endpointId: Int64) throws -> MTRBaseClusterTemperatureMeasurement {
        let controller = try MTRDeviceController.shared()
        let device = MTRBaseDevice(nodeID: NSNumber(value: deviceId), controller: controller)
        return MTRBaseClusterTemperatureMeasurement(device: device, endpointID: NSNumber(value: endpointId), queue: DispatchQueue.main)!
    }
    
    func readMeasuredValue(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<Int64?, Error>) -> Void) {
        Task {
            do {
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributeMeasuredValue();
                completion(Result.success(result.int64Value))
            }
            catch {
                os_log(.error, "Failed to read attribute MeasuredValue: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to read attribute MeasuredValue", details: nil)))
            }
        }
    }
    
    func readMinMeasuredValue(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<Int64?, Error>) -> Void) {
        Task {
            do {
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributeMinMeasuredValue();
                completion(Result.success(result.int64Value))
            }
            catch {
                os_log(.error, "Failed to read attribute MinMeasuredValue: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to read attribute MinMeasuredValue", details: nil)))
            }
        }
    }
    
    func readMaxMeasuredValue(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<Int64?, Error>) -> Void) {
        Task {
            do {
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributeMaxMeasuredValue();
                completion(Result.success(result.int64Value))
            }
            catch {
                os_log(.error, "Failed to read attribute MaxMeasuredValue: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to read attribute MaxMeasuredValue", details: nil)))
            }
        }
    }
    
    func readTolerance(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<Int64?, Error>) -> Void) {
        Task {
            do {
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributeTolerance();
                completion(Result.success(result.int64Value))
            }
            catch {
                os_log(.error, "Failed to read attribute tolerance: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to read attribute tolerance", details: nil)))
            }
        }
    }
}
