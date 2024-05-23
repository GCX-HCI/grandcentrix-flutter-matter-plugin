import 'package:flutter/services.dart';
import 'package:flutter_matter/src/clusters/descriptor_cluster.dart';
import 'package:flutter_matter/src/clusters/on_off_cluster.dart';
import 'package:flutter_matter/src/clusters/temperature_cluster.dart';
import 'package:flutter_matter/src/exceptions/flutter_matter_exceptions.dart';
import 'package:flutter_matter/src/utils/cluster_factory.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_matter/src/flutter_matter.dart';
import 'package:checks/checks.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_matter_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ClusterFactory>(),
  MockSpec<FlutterMatterDevice>(),
  MockSpec<FlutterMatterOpenPairingWindowResult>(),
  MockSpec<FlutterMatterPlatformInterface>(),
  MockSpec<DescriptorCluster>(),
  MockSpec<OnOffCluster>(),
  MockSpec<TemperatureCluster>(),
])
void main() {
  late FlutterMatter sut;

  late MockClusterFactory mockClusterFactory;
  late MockFlutterMatterPlatformInterface mockFlutterMatterPlatformInterface;
  late MockDescriptorCluster mockDescriptorCluster;
  late MockOnOffCluster mockOnOffCluster;
  late MockTemperatureCluster mockTemperatureCluster;

  setUp(() async {
    mockClusterFactory = MockClusterFactory();
    mockFlutterMatterPlatformInterface = MockFlutterMatterPlatformInterface();
    mockDescriptorCluster = MockDescriptorCluster();
    mockOnOffCluster = MockOnOffCluster();
    mockTemperatureCluster = MockTemperatureCluster();

    when(mockClusterFactory.createFlutterMatterPlatformInterface(
      appGroup: 'test',
      ecoSystemName: 'testEcoSystemName',
    )).thenAnswer((_) async => mockFlutterMatterPlatformInterface);
    when(mockClusterFactory.createDescriptorCluster())
        .thenReturn(mockDescriptorCluster);
    when(mockClusterFactory.createOnOffCluster()).thenReturn(mockOnOffCluster);
    when(mockClusterFactory.createTemperatureCluster())
        .thenReturn(mockTemperatureCluster);

    sut = await FlutterMatter.createInstance(
      appGroup: 'test',
      ecoSystemName: 'testEcoSystemName',
      fabricId: 1,
      vendorId: 0xFFF1, // Test Vendor ID
      clusterFactory: mockClusterFactory,
    );
  });

  group('getPlatformVersion', () {
    test('should return 42', () async {
      when(mockFlutterMatterPlatformInterface.getPlatformVersion())
          .thenAnswer((_) async => '42');

      await check(sut.getPlatformVersion()).completes(it()..equals('42'));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterPlatformInterface.getPlatformVersion())
          .thenAnswer((_) async => throw Exception());

      await check(sut.getPlatformVersion()).throws();
    });

    test('should transform PlatformException', () async {
      when(mockFlutterMatterPlatformInterface.getPlatformVersion())
          .thenAnswer((_) async => throw PlatformException(code: '-1'));

      await check(sut.getPlatformVersion()).throws<GeneralException>();
    });
  });

  group('commission', () {
    test('should return commissoned FlutterMatterDevice', () async {
      final mockFlutterMatterDevice = MockFlutterMatterDevice();
      when(mockFlutterMatterPlatformInterface.commission(deviceId: 123))
          .thenAnswer((_) async => mockFlutterMatterDevice);

      await check(sut.commission(deviceId: 123))
          .completes(it()..equals(mockFlutterMatterDevice));

      verify(mockFlutterMatterPlatformInterface.commission(deviceId: 123));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterPlatformInterface.commission(deviceId: 123))
          .thenAnswer((_) async => throw Exception());

      await check(sut.commission(deviceId: 123)).throws();

      verify(mockFlutterMatterPlatformInterface.commission(deviceId: 123));
    });

    test('should transform PlatformException', () async {
      when(mockFlutterMatterPlatformInterface.commission(deviceId: 123))
          .thenAnswer((_) async => throw PlatformException(code: '-1'));

      await check(sut.commission(deviceId: 123)).throws<GeneralException>();
    });
  });

  group('unpair', () {
    test('should call unpair', () async {
      await check(sut.unpair(deviceId: 123)).completes();

      verify(mockFlutterMatterPlatformInterface.unpair(deviceId: 123));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterPlatformInterface.unpair(deviceId: 123))
          .thenAnswer((_) async => throw Exception());

      await check(sut.unpair(deviceId: 123)).throws();

      verify(mockFlutterMatterPlatformInterface.unpair(deviceId: 123));
    });

    test('should transform PlatformException', () async {
      when(mockFlutterMatterPlatformInterface.unpair(deviceId: 123))
          .thenAnswer((_) async => throw PlatformException(code: '-1'));

      await check(sut.unpair(deviceId: 123)).throws<GeneralException>();
    });
  });

  group('openPairingWindowWithPin', () {
    test('should return pairing result', () async {
      final mockFlutterMatterOpenPairingWindowResult =
          MockFlutterMatterOpenPairingWindowResult();

      when(mockFlutterMatterPlatformInterface.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      )).thenAnswer((_) async => mockFlutterMatterOpenPairingWindowResult);

      await check(sut.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      )).completes(it()..equals(mockFlutterMatterOpenPairingWindowResult));

      verify(mockFlutterMatterPlatformInterface.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      ));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterPlatformInterface.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      )).thenAnswer((_) async => throw Exception());

      await check(sut.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      )).throws();

      verify(mockFlutterMatterPlatformInterface.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      ));
    });

    test('should transform PlatformException', () async {
      when(mockFlutterMatterPlatformInterface.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      )).thenAnswer((_) async => throw PlatformException(code: '-1'));

      await check(sut.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      )).throws<GeneralException>();
    });
  });

  group('Clusters', () {
    test('descriptorCluster should equal instance from ClusterFactory', () {
      check(sut.descriptorCluster).equals(mockDescriptorCluster);
    });

    test('onOffCluster should equal instance from ClusterFactory', () {
      check(sut.onOffCluster).equals(mockOnOffCluster);
    });

    test('temperatureCluster should equal instance from ClusterFactory', () {
      check(sut.temperatureCluster).equals(mockTemperatureCluster);
    });
  });
}
