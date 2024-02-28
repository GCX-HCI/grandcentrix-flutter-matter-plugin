import 'package:flutter_matter/src/utils/specifyplatformexception.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Attributes and commands for turning devices on and off
class OnOffCluster with SpecifyPlatfromException {
  final FlutterMatterOnOffClusterInterface _instance;

  /// Should not be used! Access via [FlutterMatter.onOffCluster]
  OnOffCluster(FlutterMatterOnOffClusterInterface instance)
      : _instance = instance;

  // Commands

  /// Command Off
  Future<void> off({
    required int deviceId,
    required int endpointId,
  }) =>
      catchSpecifyRethrow(() => _instance.off(
            deviceId: deviceId,
            endpointId: endpointId,
          ));

  /// Command On
  Future<void> on({
    required int deviceId,
    required int endpointId,
  }) =>
      catchSpecifyRethrow(() => _instance.on(
            deviceId: deviceId,
            endpointId: endpointId,
          ));

  /// Command Toggle
  Future<void> toggle({
    required int deviceId,
    required int endpointId,
  }) =>
      catchSpecifyRethrow(() => _instance.toggle(
            deviceId: deviceId,
            endpointId: endpointId,
          ));

  // Attributes

  /// Read attribute OnOff
  Future<bool> readOnOff({
    required int deviceId,
    required int endpointId,
  }) =>
      catchSpecifyRethrow(() => _instance.readOnOff(
            deviceId: deviceId,
            endpointId: endpointId,
          ));

  /// Subscribe to attribute OnOff
  Stream<bool> subscribeOnOff({
    required int deviceId,
    required int endpointId,
  }) =>
      catchSpecifyRethrowStream(
          _instance.subscribeOnOff(deviceId: deviceId, endpointId: endpointId));
}
