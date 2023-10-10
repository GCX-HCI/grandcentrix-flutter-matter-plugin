import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_matter/src/clusters/descriptor_cluster.dart';
import 'package:flutter_matter/src/clusters/on_off_cluster.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_matter_ios/flutter_matter_ios.dart';
import 'package:flutter_matter_android/flutter_matter_android.dart';

/// Commisson, share, read, subscribe and control Matter devices
final class FlutterMatter {
  late final FlutterMatterPlatformInterface _instance;

  /// Create instance of [FlutterMatter]
  ///
  /// Paramter [instance] is for testing
  FlutterMatter({@visibleForTesting FlutterMatterPlatformInterface? instance}) {
    if (instance != null) {
      _instance = instance;
      _setupClusters();
      return;
    } else if (Platform.isIOS) {
      _instance = FlutterMatterIos();
      _setupClusters();
      return;
    } else if (Platform.isAndroid) {
      _instance = FlutterMatterAndroid();
      _setupClusters();
      return;
    }

    throw UnimplementedError(
        'FlutterMatter currently doesn\'t support your platform!');
  }

  void _setupClusters() {
    descriptorCluster = DescriptorCluster(_instance);
    onOffCluster = OnOffCluster(_instance);
  }

  /// Sanity check test method
  @visibleForTesting
  Future<String?> getPlatformVersion() => _instance.getPlatformVersion();

  /// Commission a matter device with the provided `deviceId`
  Future<FlutterMatterDevice> commission({required int deviceId}) =>
      _instance.commission(deviceId: deviceId);

  /// Open a pairing window on the device
  Future<FlutterMatterOpenPairingWindowResult> openPairingWindowWithPin({
    required int deviceId,
    Duration duration = const Duration(minutes: 3),
    required int discriminator,
    required int setupPin,
  }) =>
      _instance.openPairingWindowWithPin(
        deviceId: deviceId,
        duration: duration,
        discriminator: discriminator,
        setupPin: setupPin,
      );

  /// Removes the app's fabric from the device
  Future<void> unpair({required int deviceId}) =>
      _instance.unpair(deviceId: deviceId);

  /// This cluster describes an endpoint instance on the node, independently from other endpoints, but also allows composition of endpoints to conform to complex device type patterns.
  ///
  /// This cluster supports a list of one or more device type identifiers that represent conformance to device type specifications.
  /// > For Example: An Extended Color Light device type may support device type IDs for both a Dimmable Light and On/Off Light, because those are subsets of an Extended Color Light (the superset).
  ///
  /// The cluster supports a PartsList attribute that is a list of zero or more endpoints to support a com­ posed device type.
  /// > For Example: A Refrigerator/Freezer appliance device type may be defined as being com­ posed of multiple Temperature Sensor endpoints, a Metering endpoint, and two Thermostat endpoints.
  late final DescriptorCluster descriptorCluster;

  /// Attributes and commands for turning devices on and off.
  late final OnOffCluster onOffCluster;
}
