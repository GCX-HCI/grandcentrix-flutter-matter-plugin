import 'package:flutter_matter_platfrom_interface/src/models/flutter_matter_descriptor_cluster_device_type_struct.dart';

abstract interface class FlutterMatterDescriptorClusterInterface {
  Future<List<FlutterMatterDescriptorClusterDeviceTypeStruct?>>
      readDeviceTypeList({
    required int deviceId,
    required int endpointId,
  });

  Future<List<int?>> readServerList({
    required int deviceId,
    required int endpointId,
  });

  Future<List<int?>> readClientList({
    required int deviceId,
    required int endpointId,
  });

  Future<List<int?>> readPartsList({
    required int deviceId,
    required int endpointId,
  });
}
