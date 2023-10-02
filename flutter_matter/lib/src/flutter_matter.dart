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

  /// Open a pairing window on the device
  Future<FlutterMatterOpenPairingWindowResult> openPairingWindowWithPin({
    required int deviceId,
    Duration duration = const Duration(minutes: 3),
    required int discriminator,
    required int setupPin,
  }) {
    return FlutterMatterPlatform.instance.openPairingWindowWithPin(
      deviceId: deviceId,
      duration: duration,
      discriminator: discriminator,
      setupPin: setupPin,
    );
  }

  /// Removes the app's fabric from the device
  Future<void> unpair({required int deviceId}) {
    return FlutterMatterPlatform.instance.unpair(deviceId: deviceId);
  }

  final OnOffCluster onOffCluster = OnOffCluster();
}
