import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// This cluster describes an endpoint instance on the node, independently from other endpoints, but also allows composition of endpoints to conform to complex device type patterns.
///
/// This cluster supports a list of one or more device type identifiers that represent conformance to device type specifications.
/// > For Example: An Extended Color Light device type may support device type IDs for both a Dimmable Light and On/Off Light, because those are subsets of an Extended Color Light (the superset).
///
/// The cluster supports a PartsList attribute that is a list of zero or more endpoints to support a com­ posed device type.
/// > For Example: A Refrigerator/Freezer appliance device type may be defined as being com­ posed of multiple Temperature Sensor endpoints, a Metering endpoint, and two Thermostat endpoints.
final class DescriptorCluster {
  final FlutterMatterPlatformInterface _instance;

  /// Should not be used! Access via [FlutterMatter.descriptorCluster]
  DescriptorCluster(FlutterMatterPlatformInterface instance)
      : _instance = instance;

  /// This is a list of device types and corresponding revisions declaring endpoint conformance (see [DeviceTypeStruct]). At least one device type entry SHALL be present.
  ///
  /// An endpoint SHALL conform to all device types listed in the DeviceTypeList. A cluster instance that is in common for more than one device type in the DeviceTypeList SHALL be supported as a shared cluster instance on the endpoint.
  /// See the System Model specification for endpoint composition.
  Future<List<FlutterMatterDescriptorClusterDeviceTypeStruct>> deviceTypeList({
    required int deviceId,
    required int endpointId,
  }) async {
    final result = await _instance.descriptorCluster
        .readDeviceTypeList(deviceId: deviceId, endpointId: endpointId);

    return result
        .where((element) => element != null)
        .cast<FlutterMatterDescriptorClusterDeviceTypeStruct>()
        .toList();
  }

  /// This attribute SHALL list each cluster ID for the server clusters present on the endpoint instance.
  Future<List<int>> serverList({
    required int deviceId,
    required int endpointId,
  }) async {
    final result = await _instance.descriptorCluster
        .readServerList(deviceId: deviceId, endpointId: endpointId);

    return result.where((element) => element != null).cast<int>().toList();
  }

  /// This attribute SHALL list each cluster ID for the client clusters present on the endpoint instance.
  Future<List<int>> clientList({
    required int deviceId,
    required int endpointId,
  }) async {
    final result = await _instance.descriptorCluster
        .readClientList(deviceId: deviceId, endpointId: endpointId);
    return result.where((element) => element != null).cast<int>().toList();
  }

  /// This attribute indicates composition of the device type instance. Device type instance composition SHALL include the endpoints in this list. See Endpoint Composition for more information.
  Future<List<int>> partsList({
    required int deviceId,
    required int endpointId,
  }) async {
    final result = await _instance.descriptorCluster
        .readPartsList(deviceId: deviceId, endpointId: endpointId);

    return result.where((element) => element != null).cast<int>().toList();
  }
}
