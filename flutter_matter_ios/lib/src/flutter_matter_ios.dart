import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_matter_ios/src/extensions.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// An implementation of [FlutterMatterPlatform] for iOS.
class FlutterMatterIos extends FlutterMatterPlatform {
  final FlutterMatterHostApi _flutterMatterHostApi;

  /// Creates a new plugin implementation instance.
  FlutterMatterIos({
    @visibleForTesting FlutterMatterHostApi? flutterMatterHostApi,
  }) : _flutterMatterHostApi = flutterMatterHostApi ?? FlutterMatterHostApi();

  /// Registers this class as the default instance of [FlutterMatterPlatform].
  static void registerWith() {
    FlutterMatterPlatform.instance = FlutterMatterIos();
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await _flutterMatterHostApi.getPlatformVersion();
    return version;
  }

  @override
  Future<FlutterMatterDevice> commission({required int deviceId}) async {
    final request = CommissionRequest(id: deviceId);
    final device = await _flutterMatterHostApi.commission(request);
    return device.toFlutterMatterDevice();
  }

  @override
  Future<void> unpair({required int deviceId}) =>
      _flutterMatterHostApi.unpair(deviceId);

  @override
  Future<FlutterMatterOpenPairingWindowResult> openPairingWindowWithPin({
    required int deviceId,
    required Duration duration,
    required int discriminator,
    required int setupPin,
  }) async {
    final result = await _flutterMatterHostApi.openPairingWindowWithPin(
      deviceId,
      duration.inSeconds,
      discriminator,
      setupPin,
    );
    return result.toFlutterMatterOpenPairingWindowResult();
  }

  @override
  Future<void> command({
    required int deviceId,
    required int endpointId,
    required FlutterMatterCluster cluster,
    required FlutterMatterCommand command,
  }) =>
      _flutterMatterHostApi.command(
        deviceId,
        endpointId,
        cluster.toCluster(),
        command.toCommand(),
      );
}
