import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// The interface that implementations of flutter_matter must implement.
abstract interface class FlutterMatterPlatformInterface {
  /// Sanity check test method
  Future<String?> getPlatformVersion();

  /// Commission a matter device with the provided `deviceId`
  Future<FlutterMatterDevice> commission({required int deviceId});

  /// Removes the app's fabric from the device
  Future<void> unpair({required int deviceId});

  /// Open a pairing window on the device
  Future<FlutterMatterOpenPairingWindowResult> openPairingWindowWithPin({
    required int deviceId,
    required Duration duration,
    required int discriminator,
    required int setupPin,
  });

  /// Access On/Off cluster
  FlutterMatterOnOffClusterInterface get onOffCluster;

  /// Access descriptor cluster
  FlutterMatterDescriptorClusterInterface get descriptorCluster;

  /// Access temperature cluster
  FlutterMatterTemperatureClusterInterface get temperatureCluster;
}
