import 'package:flutter_matter/src/on_off_cluster.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

class FlutterMatter {
  /// Sanity check test method
  Future<String?> getPlatformVersion() {
    return FlutterMatterPlatform.instance.getPlatformVersion();
  }

  /// Commission a matter device with the provided `deviceId`
  Future<FlutterMatterDevice> commission({required int deviceId}) {
    return FlutterMatterPlatform.instance.commission(deviceId: deviceId);
  }

  /// Removes the app's fabric from the device
  Future<void> unpair({required int deviceId}) {
    return FlutterMatterPlatform.instance.unpair(deviceId: deviceId);
  }

  final OnOffCluster onOffCluster = OnOffCluster();
}
