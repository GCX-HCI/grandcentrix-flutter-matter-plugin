import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_matter/src/flutter_matter.dart';
import 'package:checks/checks.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_matter_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterMatterDevice>(),
  MockSpec<FlutterMatterOpenPairingWindowResult>(),
  MockSpec<FlutterMatterPlatformInterface>(),
])
void main() {
  late FlutterMatter sut;

  late MockFlutterMatterPlatformInterface mockFlutterMatterPlatformInterface;

  setUp(() {
    mockFlutterMatterPlatformInterface = MockFlutterMatterPlatformInterface();

    sut = FlutterMatter(instance: mockFlutterMatterPlatformInterface);
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
  });
}
