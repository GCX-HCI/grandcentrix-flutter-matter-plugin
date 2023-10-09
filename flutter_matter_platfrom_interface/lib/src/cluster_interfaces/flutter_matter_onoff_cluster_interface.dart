abstract interface class FlutterMatterOnOffClusterInterface {
  Future<void> off({
    required int deviceId,
    required int endpointId,
  });

  Future<void> on({
    required int deviceId,
    required int endpointId,
  });

  Future<void> toggle({
    required int deviceId,
    required int endpointId,
  });

  Future<bool> readOnOff({
    required int deviceId,
    required int endpointId,
  });
}
