//
//  DescriptorCluster.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 04.10.23.
//

import Foundation
import OSLog
import Matter
import Flutter

class DescriptorCluster: FlutterMatterHostDescriptorClusterApi {
    
    private func getCluster(deviceId: Int64, endpointId: Int64) throws -> MTRBaseClusterDescriptor {
        let controller = try MTRDeviceController.shared()
        let device = MTRBaseDevice(nodeID: NSNumber(value: deviceId), controller: controller)
        return MTRBaseClusterDescriptor(device: device, endpointID: NSNumber(value: endpointId), queue: DispatchQueue.main)!
    }
    
    // MARK: Attributes
    
    func readDeviceTypeList(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<[DescriptorClusterDeviceTypeStruct], Error>) -> Void) {
        Task {
            do {
                let cluster: MTRBaseClusterDescriptor = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributeDeviceTypeList();
                completion(Result.success(
                    result.map { DescriptorClusterDeviceTypeStruct(
                        deviceType: ($0 as! MTRDescriptorClusterDeviceTypeStruct).deviceType.int64Value,
                        revision: ($0 as! MTRDescriptorClusterDeviceTypeStruct).revision.int64Value)
                    }))
            }
            catch {
                os_log(.error, "Failed to read attribute DeviceTypeList: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to read attribute DeviceTypeList", details: nil)))
            }
        }
    }
    
    func readServerList(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<[Int64], Error>) -> Void) {
        Task {
            do {
                let cluster: MTRBaseClusterDescriptor = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributeServerList();
                completion(Result.success(
                    result.map {
                        ($0 as! NSNumber).int64Value
                    }))
            }
            catch {
                os_log(.error, "Failed to read attribute ServerList: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to read attribute ServerList", details: nil)))
            }
        }
    }
    
    func readClientList(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<[Int64], Error>) -> Void) {
        Task {
            do {
                let cluster: MTRBaseClusterDescriptor = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributeClientList();
                completion(Result.success(
                    result.map {
                        ($0 as! NSNumber).int64Value
                    }))
            }
            catch {
                os_log(.error, "Failed to read attribute ClientList: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to read attribute ClientList", details: nil)))
            }
        }
    }
    
    func readPartsList(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<[Int64], Error>) -> Void) {
        Task {
            do {
                let cluster: MTRBaseClusterDescriptor = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributePartsList();
                completion(Result.success(
                    result.map {
                        ($0 as! NSNumber).int64Value
                    }))
            }
            catch {
                os_log(.error, "Failed to read attribute PartsList: \(error)")
                completion(Result.failure(FlutterError(code: "-1", message: "Failed to read attribute PartsList", details: nil)))
            }
        }
    }
}
