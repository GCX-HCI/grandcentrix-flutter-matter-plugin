import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// An implementation of [FlutterMatterPlatform] for iOS.
class FlutterMatterIos extends FlutterMatterPlatform {
  final FlutterMatterHostApi _flutterMatterHostApi;

  /// Creates a new plugin implementation instance.
  FlutterMatterIos({
    @visibleForTesting FlutterMatterHostApi? flutterMatterHostApi,
  }) : _flutterMatterHostApi = flutterMatterHostApi ?? FlutterMatterHostApi();

  @override
  Future<String?> getPlatformVersion() async {
    final version = await _flutterMatterHostApi.getPlatformVersion();
    return version;
  }

  /// Registers this class as the default instance of [FlutterMatterPlatform].
  static void registerWith() {
    FlutterMatterPlatform.instance = FlutterMatterIos();
  }
}
