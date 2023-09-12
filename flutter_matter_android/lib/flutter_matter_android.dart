import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_matter_android/src/extensions.dart';
import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// An implementation of [FlutterMatterPlatform] for Android.
class FlutterMatterAndroid extends FlutterMatterPlatform {
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

  /// Registers this class as the default instance of [FlutterMatterPlatform].
  static void registerWith() {
    FlutterMatterPlatform.instance = FlutterMatterAndroid();
  }
}
