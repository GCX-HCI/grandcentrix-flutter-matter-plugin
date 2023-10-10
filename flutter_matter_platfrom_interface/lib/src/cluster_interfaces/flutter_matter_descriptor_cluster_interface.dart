import 'package:flutter_matter_platfrom_interface/src/models/flutter_matter_descriptor_cluster_device_type_struct.dart';

/// The interface that implementations of flutter_matter must implement.
abstract interface class FlutterMatterDescriptorClusterInterface {
  /// Read attribute device type list
  Future<List<FlutterMatterDescriptorClusterDeviceTypeStruct?>>
      readDeviceTypeList({
    required int deviceId,
    required int endpointId,
  });

  /// Read attribute server list
  Future<List<int?>> readServerList({
    required int deviceId,
    required int endpointId,
  });

  /// Read attribute client list
  Future<List<int?>> readClientList({
    required int deviceId,
    required int endpointId,
  });

  /// Read attribute parts list
  Future<List<int?>> readPartsList({
    required int deviceId,
    required int endpointId,
  });
}
