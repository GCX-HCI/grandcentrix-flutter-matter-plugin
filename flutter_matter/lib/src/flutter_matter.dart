import 'package:flutter_matter/src/clusters/descriptor_cluster.dart';
import 'package:flutter_matter/src/clusters/on_off_cluster.dart';
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

  /// This cluster describes an endpoint instance on the node, independently from other endpoints, but also allows composition of endpoints to conform to complex device type patterns.
  ///
  /// This cluster supports a list of one or more device type identifiers that represent conformance to device type specifications.
  /// > For Example: An Extended Color Light device type may support device type IDs for both a Dimmable Light and On/Off Light, because those are subsets of an Extended Color Light (the superset).
  ///
  /// The cluster supports a PartsList attribute that is a list of zero or more endpoints to support a com­ posed device type.
  /// > For Example: A Refrigerator/Freezer appliance device type may be defined as being com­ posed of multiple Temperature Sensor endpoints, a Metering endpoint, and two Thermostat endpoints.
  final DescriptorCluster descriptorCluster = DescriptorCluster();

  /// Attributes and commands for turning devices on and off.
  final OnOffCluster onOffCluster = OnOffCluster();
}
