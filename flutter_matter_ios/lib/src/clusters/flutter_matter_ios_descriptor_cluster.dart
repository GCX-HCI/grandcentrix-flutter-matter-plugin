import 'package:flutter/foundation.dart';
import 'package:flutter_matter_ios/src/extensions/descriptor_cluster_device_type_struct_transformation_extension.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// This cluster describes an endpoint instance on the node, independently from other endpoints, but also allows composition of endpoints to conform to complex device type patterns.
///
/// This cluster supports a list of one or more device type identifiers that represent conformance to device type specifications.
/// > For Example: An Extended Color Light device type may support device type IDs for both a Dimmable Light and On/Off Light, because those are subsets of an Extended Color Light (the superset).
///
/// The cluster supports a PartsList attribute that is a list of zero or more endpoints to support a com­ posed device type.
/// > For Example: A Refrigerator/Freezer appliance device type may be defined as being com­ posed of multiple Temperature Sensor endpoints, a Metering endpoint, and two Thermostat endpoints
final class FlutterMatterIosDescriptorCluster
    implements FlutterMatterDescriptorClusterInterface {
  final FlutterMatterHostDescriptorClusterApi
      _flutterMatterHostDescriptorClusterApi;

  /// Creates a new Descriptor cluster implementation instance.
  FlutterMatterIosDescriptorCluster({
    @visibleForTesting
    FlutterMatterHostDescriptorClusterApi?
        flutterMatterHostDescriptorClusterApi,
  }) : _flutterMatterHostDescriptorClusterApi =
            flutterMatterHostDescriptorClusterApi ??
                FlutterMatterHostDescriptorClusterApi();

  @override
  Future<List<int?>> readClientList(
          {required int deviceId, required int endpointId}) =>
      _flutterMatterHostDescriptorClusterApi.readClientList(
          deviceId, endpointId);

  @override
  Future<List<FlutterMatterDescriptorClusterDeviceTypeStruct?>>
      readDeviceTypeList(
          {required int deviceId, required int endpointId}) async {
    final result = await _flutterMatterHostDescriptorClusterApi
        .readDeviceTypeList(deviceId, endpointId);

    return result
        .map((e) => e?.toFlutterMatterDescriptorClusterDeviceTypeStruct())
        .toList();
  }

  @override
  Future<List<int?>> readPartsList(
          {required int deviceId, required int endpointId}) =>
      _flutterMatterHostDescriptorClusterApi.readPartsList(
          deviceId, endpointId);

  @override
  Future<List<int?>> readServerList(
          {required int deviceId, required int endpointId}) =>
      _flutterMatterHostDescriptorClusterApi.readServerList(
          deviceId, endpointId);
}
