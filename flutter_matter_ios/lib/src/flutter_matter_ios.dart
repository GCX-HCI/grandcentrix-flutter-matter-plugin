import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_matter_ios/src/extensions/matter_device_transformation_extension.dart';
import 'package:flutter_matter_ios/src/extensions/open_pairing_window_result_transformation_extension.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// An implementation of [FlutterMatterPlatformInterface] for iOS.
class FlutterMatterIos implements FlutterMatterPlatformInterface {
  final FlutterMatterHostApi _flutterMatterHostApi;
  final String _ecoSystemName;

  /// Creates a new plugin implementation instance.
  FlutterMatterIos._({
    required String ecoSystemName,
    @visibleForTesting FlutterMatterHostApi? flutterMatterHostApi,
  })  : _ecoSystemName = ecoSystemName,
        _flutterMatterHostApi = flutterMatterHostApi ?? FlutterMatterHostApi();

  /// Async factory method to create a [FlutterMatterIos] instance and initialize the iOS UserDefaults
  static Future<FlutterMatterIos> createInstance({
    required String appGroup,
    required String ecoSystemName,
    @visibleForTesting FlutterMatterHostApi? flutterMatterHostApi,
  }) async {
    final instance = FlutterMatterIos._(
      ecoSystemName: ecoSystemName,
      flutterMatterHostApi: flutterMatterHostApi,
    );
    await instance._flutterMatterHostApi.initUserDefaults(appGroup);
    return instance;
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await _flutterMatterHostApi.getPlatformVersion();
    return version;
  }

  @override
  Future<FlutterMatterDevice> commission({required int deviceId}) async {
    final request = CommissionRequest(
      id: deviceId,
      ecoSystemName: _ecoSystemName,
    );
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
