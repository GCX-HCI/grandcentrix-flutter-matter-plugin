import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// An implementation of [FlutterMatterPlatform] that uses method channels.
class MethodChannelFlutterMatter extends FlutterMatterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_matter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<FlutterMatterDevice> commission({required int deviceId}) {
    throw UnimplementedError();
  }

  @override
  FlutterMatterDescriptorClusterInterface get descriptorCluster =>
      throw UnimplementedError();

  @override
  FlutterMatterOnOffClusterInterface get onOffCluster =>
      throw UnimplementedError();

  @override
  Future<FlutterMatterOpenPairingWindowResult> openPairingWindowWithPin(
      {required int deviceId,
      required Duration duration,
      required int discriminator,
      required int setupPin}) {
    throw UnimplementedError();
  }

  @override
  Future<void> unpair({required int deviceId}) {
    throw UnimplementedError();
  }
}
