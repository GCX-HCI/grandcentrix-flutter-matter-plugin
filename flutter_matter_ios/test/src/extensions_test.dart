import 'package:checks/checks.dart';
import 'package:flutter_matter_ios/src/extensions.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MatterDeviceTransformationExtension', () {
    test('toFlutterMatterDevice should return correct values', () {
      final matterDevice = MatterDevice(id: 123);
      final sut = matterDevice.toFlutterMatterDevice();

      check(sut).has((p0) => p0.id, 'id').equals(123);
    });
  });

  group('FlutterMatterClusterTransformationExtension', () {
    test('should transfrom FlutterMatterCluster.onOff to Cluster.onOff', () {
      check(FlutterMatterCluster.onOff.toCluster()).equals(Cluster.onOff);
    });
  });

  group('FlutterMatterCommandTransformationExtension', () {
    test('should transfrom FlutterMatterCommand.off to Command.off', () {
      check(FlutterMatterCommand.off.toCommand()).equals(Command.off);
    });

    test('should transfrom FlutterMatterCommand.on to Command.on', () {
      check(FlutterMatterCommand.on.toCommand()).equals(Command.on);
    });

    test('should transfrom FlutterMatterCommand.toggle to Command.toggle', () {
      check(FlutterMatterCommand.toggle.toCommand()).equals(Command.toggle);
    });
  });

  group('FlutterMatterAttributeTransformationExtension', () {
    test('should transfrom FlutterMatterAttribute.off to Attribute.off', () {
      check(FlutterMatterAttribute.onOff.toAttribute()).equals(Attribute.onOff);
    });
  });

  group('OpenPairingWindowResultTransformationExtension', () {
    test('toFlutterMatterOpenPairingWindowResult should return connrect values',
        () {
      check(OpenPairingWindowResult(
              manualPairingCode: '1234', qrCode: 'qrCode123')
          .toFlutterMatterOpenPairingWindowResult())
        ..has((p0) => p0.manualPairingCode, 'manualPairingCode').equals('1234')
        ..has((p0) => p0.qrCode, 'qrCode').equals('qrCode123');
    });
  });
}
