import 'package:flutter/foundation.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Attributes and commands for turning devices on and off
final class FlutterMatterIosOnOffCluster
    implements FlutterMatterOnOffClusterInterface {
  final FlutterMatterHostOnOffClusterApi _flutterMatterHostOnOffClusterApi;

  /// Creates a new OnOff cluster implementation instance.
  FlutterMatterIosOnOffCluster({
    @visibleForTesting
    FlutterMatterHostOnOffClusterApi? flutterMatterHostOnOffClusterApi,
  }) : _flutterMatterHostOnOffClusterApi = flutterMatterHostOnOffClusterApi ??
            FlutterMatterHostOnOffClusterApi();

  @override
  Future<void> off({required int deviceId, required int endpointId}) =>
      _flutterMatterHostOnOffClusterApi.off(deviceId, endpointId);

  @override
  Future<void> on({required int deviceId, required int endpointId}) =>
      _flutterMatterHostOnOffClusterApi.on(deviceId, endpointId);

  @override
  Future<void> toggle({required int deviceId, required int endpointId}) =>
      _flutterMatterHostOnOffClusterApi.toggle(deviceId, endpointId);

  @override
  Future<bool> readOnOff({required int deviceId, required int endpointId}) =>
      _flutterMatterHostOnOffClusterApi.readOnOff(deviceId, endpointId);
}
