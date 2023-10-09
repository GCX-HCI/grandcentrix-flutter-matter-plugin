import 'package:flutter/foundation.dart';
import 'package:flutter_matter_android/src/extensions/descriptor_cluster_device_type_struct_transformation_extension.dart';
import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

final class FlutterMatterAndroidDescriptorCluster
    implements FlutterMatterDescriptorClusterInterface {
  final FlutterMatterHostDescriptorClusterApi
      _flutterMatterHostDescriptorClusterApi;

  /// Creates a new OnOff cluster implementation instance.
  FlutterMatterAndroidDescriptorCluster({
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
