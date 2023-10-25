import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_matter_ios/src/clusters/flutter_matter_ios_descriptor_cluster.dart';
import 'package:flutter_matter_ios/src/clusters/flutter_matter_ios_onoff_cluster.dart';
import 'package:flutter_matter_ios/src/clusters/flutter_matter_ios_temperature_cluster.dart';
import 'package:flutter_matter_ios/src/extensions/matter_device_transformation_extension.dart';
import 'package:flutter_matter_ios/src/extensions/open_pairing_window_result_transformation_extension.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// An implementation of [FlutterMatterPlatformInterface] for iOS.
class FlutterMatterIos implements FlutterMatterPlatformInterface {
  final FlutterMatterHostApi _flutterMatterHostApi;
  final FlutterMatterOnOffClusterInterface _flutterMatterOnOffClusterInterface;
  final FlutterMatterDescriptorClusterInterface
      _flutterMatterDescriptorClusterInterface;
  final FlutterMatterTemperatureClusterInterface
      _flutterMatterTemperatureClusterInterface;

  /// Creates a new plugin implementation instance.
  FlutterMatterIos._({
    @visibleForTesting FlutterMatterHostApi? flutterMatterHostApi,
    @visibleForTesting
    FlutterMatterOnOffClusterInterface? flutterMatterOnOffClusterInterface,
    @visibleForTesting
    FlutterMatterDescriptorClusterInterface?
        flutterMatterDescriptorClusterInterface,
    @visibleForTesting
    FlutterMatterTemperatureClusterInterface?
        flutterMatterTemperatureClusterInterface,
  })  : _flutterMatterHostApi = flutterMatterHostApi ?? FlutterMatterHostApi(),
        _flutterMatterOnOffClusterInterface =
            flutterMatterOnOffClusterInterface ??
                FlutterMatterIosOnOffCluster(),
        _flutterMatterDescriptorClusterInterface =
            flutterMatterDescriptorClusterInterface ??
                FlutterMatterIosDescriptorCluster(),
        _flutterMatterTemperatureClusterInterface =
            flutterMatterTemperatureClusterInterface ??
                FlutterMatterIosTemperatureCluster();

  /// Async factory method to create a [FlutterMatterIos] instance and initialize the iOS UserDefaults
  static Future<FlutterMatterIos> createInstance({
    required String appGroup,
    @visibleForTesting FlutterMatterHostApi? flutterMatterHostApi,
    @visibleForTesting
    FlutterMatterOnOffClusterInterface? flutterMatterOnOffClusterInterface,
    @visibleForTesting
    FlutterMatterDescriptorClusterInterface?
        flutterMatterDescriptorClusterInterface,
  }) async {
    final instance = FlutterMatterIos._(
      flutterMatterHostApi: flutterMatterHostApi,
      flutterMatterOnOffClusterInterface: flutterMatterOnOffClusterInterface,
      flutterMatterDescriptorClusterInterface:
          flutterMatterDescriptorClusterInterface,
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
  FlutterMatterOnOffClusterInterface get onOffCluster =>
      _flutterMatterOnOffClusterInterface;

  @override
  FlutterMatterDescriptorClusterInterface get descriptorCluster =>
      _flutterMatterDescriptorClusterInterface;

  @override
  FlutterMatterTemperatureClusterInterface get temperatureCluster =>
      _flutterMatterTemperatureClusterInterface;
}
