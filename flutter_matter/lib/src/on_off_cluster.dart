import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

final class OnOffCluster {
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
}
