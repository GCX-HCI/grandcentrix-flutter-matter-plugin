import 'package:flutter_matter/src/utils/specifyplatformexception.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Attributes and commands for turning devices on and off
final class OnOffCluster with SpecifyPlatfromException {
  final FlutterMatterPlatformInterface _instance;

  /// Should not be used! Access via [FlutterMatter.onOffCluster]
  OnOffCluster(FlutterMatterPlatformInterface instance) : _instance = instance;

  // Commands

  /// Command Off
  Future<void> off({
    required int deviceId,
    required int endpointId,
  }) =>
      catchSpecifyRethrow(() => _instance.onOffCluster.off(
            deviceId: deviceId,
            endpointId: endpointId,
          ));

  /// Command On
  Future<void> on({
    required int deviceId,
    required int endpointId,
  }) =>
      catchSpecifyRethrow(() => _instance.onOffCluster.on(
            deviceId: deviceId,
            endpointId: endpointId,
          ));

  /// Command Toggle
  Future<void> toggle({
    required int deviceId,
    required int endpointId,
  }) =>
      catchSpecifyRethrow(() => _instance.onOffCluster.toggle(
            deviceId: deviceId,
            endpointId: endpointId,
          ));

  // Attributes

  /// Read attribute OnOff
  Future<bool> readOnOff({
    required int deviceId,
    required int endpointId,
  }) =>
      catchSpecifyRethrow(() => _instance.onOffCluster.readOnOff(
            deviceId: deviceId,
            endpointId: endpointId,
          ));

  /// Subscribe to attribute OnOff
  Stream<bool> subscribeOnOff({
    required int deviceId,
    required int endpointId,
  }) =>
      catchSpecifyRethrowStream(_instance.onOffCluster
          .subscribeOnOff(deviceId: deviceId, endpointId: endpointId));
}
