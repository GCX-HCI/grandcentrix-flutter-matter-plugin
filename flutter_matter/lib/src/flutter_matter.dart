import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_matter/src/clusters/descriptor_cluster.dart';
import 'package:flutter_matter/src/clusters/on_off_cluster.dart';
import 'package:flutter_matter/src/clusters/temperature_cluster.dart';
import 'package:flutter_matter/src/utils/cluster_factory.dart';
import 'package:flutter_matter/src/utils/specifyplatformexception.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Commisson, share, read, subscribe and control Matter devices
final class FlutterMatter with SpecifyPlatfromException {
  final FlutterMatterPlatformInterface _platfromInterface;

  FlutterMatter._({
    required FlutterMatterPlatformInterface platfromInterface,
    required this.descriptorCluster,
    required this.onOffCluster,
    required this.temperatureCluster,
  }) : _platfromInterface = platfromInterface;

  /// Create instance of [FlutterMatter]
  ///
  /// Parameter [appGroup] should be your App Group you defined in the iOS App Group capabilities. See the README for setup.
  /// Throws an [UnimplementedError], when your Platfrom is not iOS or Android!
  ///
  /// Paramter [clusterFactory] is only for testing
  static Future<FlutterMatter> createInstance({
    required String appGroup,
    @visibleForTesting ClusterFactory? clusterFactory,
  }) async {
    final factory = clusterFactory ?? ClusterFactory();
    return FlutterMatter._(
      platfromInterface: await factory.createFlutterMatterPlatformInterface(
          appGroup: appGroup),
      descriptorCluster: factory.createDescriptorCluster(),
      onOffCluster: factory.createOnOffCluster(),
      temperatureCluster: factory.createTemperatureCluster(),
    );
  }

  /// Sanity check test method
  @visibleForTesting
  Future<String?> getPlatformVersion() =>
      catchSpecifyRethrow(() => _platfromInterface.getPlatformVersion());

  /// Commission a matter device with the provided `deviceId`
  Future<FlutterMatterDevice> commission({required int deviceId}) =>
      catchSpecifyRethrow(
          () => _platfromInterface.commission(deviceId: deviceId));

  /// Open a pairing window on the device
  Future<FlutterMatterOpenPairingWindowResult> openPairingWindowWithPin({
    required int deviceId,
    Duration duration = const Duration(minutes: 3),
    required int discriminator,
    required int setupPin,
  }) =>
      catchSpecifyRethrow(() => _platfromInterface.openPairingWindowWithPin(
            deviceId: deviceId,
            duration: duration,
            discriminator: discriminator,
            setupPin: setupPin,
          ));

  /// Removes the app's fabric from the device
  Future<void> unpair({required int deviceId}) =>
      catchSpecifyRethrow(() => _platfromInterface.unpair(deviceId: deviceId));

  /// This cluster describes an endpoint instance on the node, independently from other endpoints, but also allows composition of endpoints to conform to complex device type patterns.
  ///
  /// This cluster supports a list of one or more device type identifiers that represent conformance to device type specifications.
  /// > For Example: An Extended Color Light device type may support device type IDs for both a Dimmable Light and On/Off Light, because those are subsets of an Extended Color Light (the superset).
  ///
  /// The cluster supports a PartsList attribute that is a list of zero or more endpoints to support a com­ posed device type.
  /// > For Example: A Refrigerator/Freezer appliance device type may be defined as being com­ posed of multiple Temperature Sensor endpoints, a Metering endpoint, and two Thermostat endpoints.
  final DescriptorCluster descriptorCluster;

  /// Attributes and commands for turning devices on and off.
  final OnOffCluster onOffCluster;

  /// Attributes to temperature measurement functionality.
  final TemperatureCluster temperatureCluster;
}
