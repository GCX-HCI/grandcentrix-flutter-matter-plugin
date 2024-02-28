import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_matter_android/src/extensions/matter_device_transformation_extension.dart';
import 'package:flutter_matter_android/src/extensions/open_pairing_window_result_transformation_extension.dart';
import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// An implementation of [FlutterMatterPlatformInterface] for iOS.
class FlutterMatterAndroid implements FlutterMatterPlatformInterface {
  final FlutterMatterHostApi _flutterMatterHostApi;

  /// Creates a new plugin implementation instance.
  FlutterMatterAndroid({
    @visibleForTesting FlutterMatterHostApi? flutterMatterHostApi,
  }) : _flutterMatterHostApi = flutterMatterHostApi ?? FlutterMatterHostApi();

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
}
