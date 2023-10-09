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
  MockSpec<FlutterMatterPlatform>(),
])
void main() {
  late FlutterMatter sut;

  late MockFlutterMatterPlatform mockFlutterMatterPlatform;

  setUp(() {
    mockFlutterMatterPlatform = MockFlutterMatterPlatform();

    sut = FlutterMatter();

    FlutterMatterPlatform.skipVerifyForTesting = true;
    FlutterMatterPlatform.instance = mockFlutterMatterPlatform;
  });

  group('getPlatformVersion', () {
    test('should return 42', () async {
      when(mockFlutterMatterPlatform.getPlatformVersion())
          .thenAnswer((_) async => '42');

      await check(sut.getPlatformVersion()).completes(it()..equals('42'));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterPlatform.getPlatformVersion())
          .thenAnswer((_) async => throw Exception());

      await check(sut.getPlatformVersion()).throws();
    });
  });

  group('commission', () {
    test('should return commissoned FlutterMatterDevice', () async {
      final mockFlutterMatterDevice = MockFlutterMatterDevice();
      when(mockFlutterMatterPlatform.commission(deviceId: 123))
          .thenAnswer((_) async => mockFlutterMatterDevice);

      await check(sut.commission(deviceId: 123))
          .completes(it()..equals(mockFlutterMatterDevice));

      verify(mockFlutterMatterPlatform.commission(deviceId: 123));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterPlatform.commission(deviceId: 123))
          .thenAnswer((_) async => throw Exception());

      await check(sut.commission(deviceId: 123)).throws();

      verify(mockFlutterMatterPlatform.commission(deviceId: 123));
    });
  });

  group('unpair', () {
    test('should call unpair', () async {
      await check(sut.unpair(deviceId: 123)).completes();

      verify(mockFlutterMatterPlatform.unpair(deviceId: 123));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterPlatform.unpair(deviceId: 123))
          .thenAnswer((_) async => throw Exception());

      await check(sut.unpair(deviceId: 123)).throws();

      verify(mockFlutterMatterPlatform.unpair(deviceId: 123));
    });
  });

  group('openPairingWindowWithPin', () {
    test('should return pairing result', () async {
      final mockFlutterMatterOpenPairingWindowResult =
          MockFlutterMatterOpenPairingWindowResult();

      when(mockFlutterMatterPlatform.openPairingWindowWithPin(
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

      verify(mockFlutterMatterPlatform.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      ));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterPlatform.openPairingWindowWithPin(
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

      verify(mockFlutterMatterPlatform.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      ));
    });
  });
}
