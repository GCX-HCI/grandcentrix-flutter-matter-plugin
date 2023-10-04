import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Extensions for MatterDevice
extension MatterDeviceTransformationExtension on MatterDevice {
  /// Transfrom MatterDevice to FlutterMatterDevice
  FlutterMatterDevice toFlutterMatterDevice() {
    return FlutterMatterDevice(id: id);
  }
}

/// Extensions for FlutterMatterCluster
extension FlutterMatterClusterTransformationExtension on FlutterMatterCluster {
  /// Transfrom FlutterMatterCluster to Cluster
  Cluster toCluster() {
    return switch (this) {
      FlutterMatterCluster.onOff => Cluster.onOff,
      // ignore: unreachable_switch_case
      _ => throw UnimplementedError(
          'Transformation for $name has not been implemented.')
    };
  }
}

/// Extensions for FlutterMatterCommand
extension FlutterMatterCommandTransformationExtension on FlutterMatterCommand {
  /// Transfrom FlutterMatterCommand to Command
  Command toCommand() {
    return switch (this) {
      FlutterMatterCommand.off => Command.off,
      FlutterMatterCommand.on => Command.on,
      FlutterMatterCommand.toggle => Command.toggle,
      // ignore: unreachable_switch_case
      _ => throw UnimplementedError(
          'Transformation for $name has not been implemented.')
    };
  }
}

/// Extensions for FlutterMatterAttribute
extension FlutterMatterAttributeTransformationExtension
    on FlutterMatterAttribute {
  /// Transfrom FlutterMatterAttribute to Attribute
  Attribute toAttribute() {
    return switch (this) {
      FlutterMatterAttribute.onOff => Attribute.onOff,
      // ignore: unreachable_switch_case
      _ => throw UnimplementedError(
          'Transformation for $name has not been implemented.')
    };
  }
}

/// Extensions for OpenPairingWindowResult
extension OpenPairingWindowResultTransformationExtension
    on OpenPairingWindowResult {
  /// Transfrom OpenPairingWindowResult to FlutterMatterOpenPairingWindowResult
  FlutterMatterOpenPairingWindowResult
      toFlutterMatterOpenPairingWindowResult() {
    return FlutterMatterOpenPairingWindowResult(
        manualPairingCode: manualPairingCode, qrCode: qrCode);
  }
}
