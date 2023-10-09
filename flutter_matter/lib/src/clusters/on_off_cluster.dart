import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Attributes and commands for turning devices on and off
final class OnOffCluster {
  // Commands

  /// Command Off
  Future<void> off({
    required int deviceId,
    required int endpointId,
  }) =>
      FlutterMatterPlatform.instance.onOffCluster.off(
        deviceId: deviceId,
        endpointId: endpointId,
      );

  /// Command On
  Future<void> on({
    required int deviceId,
    required int endpointId,
  }) =>
      FlutterMatterPlatform.instance.onOffCluster.on(
        deviceId: deviceId,
        endpointId: endpointId,
      );

  /// Command Toggle
  Future<void> toggle({
    required int deviceId,
    required int endpointId,
  }) =>
      FlutterMatterPlatform.instance.onOffCluster.toggle(
        deviceId: deviceId,
        endpointId: endpointId,
      );

  // Attributes

  /// Attribute OnOff
  Future<bool> readOnOff({
    required int deviceId,
    required int endpointId,
  }) =>
      FlutterMatterPlatform.instance.onOffCluster.readOnOff(
        deviceId: deviceId,
        endpointId: endpointId,
      );
}
