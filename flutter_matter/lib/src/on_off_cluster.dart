import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Attributes and commands for turning devices on and off
final class OnOffCluster {
  // Commands

  /// Command Off
  Future<void> off({
    required int deviceId,
    required int endpointId,
  }) =>
      FlutterMatterPlatform.instance.command(
        deviceId: deviceId,
        endpointId: endpointId,
        cluster: FlutterMatterCluster.onOff,
        command: FlutterMatterCommand.off,
      );

  /// Command On
  Future<void> on({
    required int deviceId,
    required int endpointId,
  }) =>
      FlutterMatterPlatform.instance.command(
        deviceId: deviceId,
        endpointId: endpointId,
        cluster: FlutterMatterCluster.onOff,
        command: FlutterMatterCommand.on,
      );

  /// Command Toggle
  Future<void> toggle({
    required int deviceId,
    required int endpointId,
  }) =>
      FlutterMatterPlatform.instance.command(
        deviceId: deviceId,
        endpointId: endpointId,
        cluster: FlutterMatterCluster.onOff,
        command: FlutterMatterCommand.toggle,
      );

  // Attributes

  /// Attribute OnOff
  Future<bool> onOff({
    required int deviceId,
    required int endpointId,
  }) async {
    final result = await FlutterMatterPlatform.instance.attribute(
      deviceId: deviceId,
      endpointId: endpointId,
      cluster: FlutterMatterCluster.onOff,
      attribute: FlutterMatterAttribute.onOff,
    );
    return result as bool;
  }
}
