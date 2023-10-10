/// The interface that implementations of flutter_matter must implement.
abstract interface class FlutterMatterOnOffClusterInterface {
  /// Command off
  Future<void> off({
    required int deviceId,
    required int endpointId,
  });

  /// Command on
  Future<void> on({
    required int deviceId,
    required int endpointId,
  });

  /// Command toggle
  Future<void> toggle({
    required int deviceId,
    required int endpointId,
  });

  /// Read attribute OnOff
  Future<bool> readOnOff({
    required int deviceId,
    required int endpointId,
  });

  /// Subscribe to attribute OnOff
  Stream<bool> subscribeOnOff({
    required int deviceId,
    required int endpointId,
  });
}
