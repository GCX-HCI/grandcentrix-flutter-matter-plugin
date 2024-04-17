//
//  DescriptorCluster.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 04.10.23.
//

import Flutter
import Foundation
import Matter
import OSLog

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
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributeDeviceTypeList()
                let deviceTypes = result.compactMap { value -> DescriptorClusterDeviceTypeStruct? in
                    guard let deviceType = value as? MTRDescriptorClusterDeviceTypeStruct else {
                        return nil
                    }
                    return DescriptorClusterDeviceTypeStruct(deviceType: deviceType.deviceType.int64Value, revision: deviceType.revision.int64Value)
                }
                completion(.success(deviceTypes))
            } catch {
                os_log(.error, "Failed to read attribute DeviceTypeList: \(error)")
                completion(.failure(FlutterError(code: "-1", message: "Failed to read attribute DeviceTypeList", details: nil)))
            }
        }
    }

    func readServerList(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<[Int64], Error>) -> Void) {
        Task {
            do {
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributeServerList()
                let serverList = result.compactMap { value -> Int64? in
                    guard let number = value as? NSNumber else {
                        return nil
                    }
                    return number.int64Value
                }
                completion(.success(serverList))
            } catch {
                os_log(.error, "Failed to read attribute ServerList: \(error)")
                completion(.failure(FlutterError(code: "-1", message: "Failed to read attribute ServerList", details: nil)))
            }
        }
    }

    func readClientList(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<[Int64], Error>) -> Void) {
        Task {
            do {
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributeClientList()
                let clientList = result.compactMap { value -> Int64? in
                    guard let number = value as? NSNumber else {
                        return nil
                    }
                    return number.int64Value
                }
                completion(.success(clientList))
            } catch {
                os_log(.error, "Failed to read attribute ClientList: \(error)")
                completion(.failure(FlutterError(code: "-1", message: "Failed to read attribute ClientList", details: nil)))
            }
        }
    }

    func readPartsList(deviceId: Int64, endpointId: Int64, completion: @escaping (Result<[Int64], Error>) -> Void) {
        Task {
            do {
                let cluster = try getCluster(deviceId: deviceId, endpointId: endpointId)
                let result = try await cluster.readAttributePartsList()
                let partsList = result.compactMap { value -> Int64? in
                    guard let number = value as? NSNumber else {
                        return nil
                    }
                    return number.int64Value
                }
                completion(.success(partsList))
            } catch {
                os_log(.error, "Failed to read attribute PartsList: \(error)")
                completion(.failure(FlutterError(code: "-1", message: "Failed to read attribute PartsList", details: nil)))
            }
        }
    }
}
