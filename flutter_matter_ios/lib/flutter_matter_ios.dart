import 'package:flutter/services.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// An implementation of [FlutterMatterPlatform] that uses method channels.
class FlutterMatterIos extends FlutterMatterPlatform {
  /// The method channel used to interact with the native platform.
  final _methodChannel = const MethodChannel('flutter_matter');

  /// Registers this class as the default instance of [FlutterMatterPlatform].
  static void registerWith() {
    FlutterMatterPlatform.instance = FlutterMatterIos();
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await _methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
