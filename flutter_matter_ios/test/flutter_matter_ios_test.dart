import 'package:checks/checks.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_ios/src/flutter_matter_ios.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './flutter_matter_ios_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterMatterHostApi>(),
  MockSpec<MatterDevice>(),
  MockSpec<OpenPairingWindowResult>(),
  MockSpec<FlutterMatterOnOffClusterInterface>(),
  MockSpec<FlutterMatterDescriptorClusterInterface>(),
])
void main() {
  late FlutterMatterIos sut;
  late MockFlutterMatterHostApi mockFlutterMatterHostApi;

  setUp(() async {
    mockFlutterMatterHostApi = MockFlutterMatterHostApi();

    sut = await FlutterMatterIos.createInstance(
      appGroup: 'test',
      ecoSystemName: 'testEcoSystemName',
      flutterMatterHostApi: mockFlutterMatterHostApi,
    );
  });

  group('createInstance', () {
    test('should call initUserDefaults', () {
      verify(mockFlutterMatterHostApi.initUserDefaults('test'));
    });
  });

  group('getPlatformVersion', () {
    test('should call host api', () async {
      when(mockFlutterMatterHostApi.getPlatformVersion())
          .thenAnswer((_) async => '42');

      await check(sut.getPlatformVersion()).completes(it()..equals('42'));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostApi.getPlatformVersion())
          .thenAnswer((_) async => throw Exception());

      await check(sut.getPlatformVersion()).throws();
    });
  });

  group('commission', () {
    test('should call host api', () async {
      final mockMatterDevice = MockMatterDevice();

      when(mockMatterDevice.id).thenReturn(123);
      when(mockFlutterMatterHostApi.commission(any))
          .thenAnswer((_) async => mockMatterDevice);

      await check(sut.commission(deviceId: 123))
          .completes(it()..equals(FlutterMatterDevice(id: 123)));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostApi.commission(any))
          .thenAnswer((_) async => throw Exception());

      await check(sut.commission(deviceId: 123)).throws();
    });
  });

  group('unpair', () {
    test('should call host api', () async {
      await check(sut.unpair(deviceId: 123)).completes();

      verify(mockFlutterMatterHostApi.unpair(123));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostApi.unpair(123))
          .thenAnswer((_) async => throw Exception());

      await check(sut.unpair(deviceId: 123)).throws();
    });
  });

  group('openPairingWindowWithPin', () {
    test('should call host api', () async {
      final mockOpenPairingWindowResult = MockOpenPairingWindowResult();

      when(mockOpenPairingWindowResult.manualPairingCode)
          .thenReturn('manualPairingCode123');
      when(mockOpenPairingWindowResult.qrCode).thenReturn('qrCode123');
      when(mockFlutterMatterHostApi.openPairingWindowWithPin(
              123, 180, 456, 789))
          .thenAnswer((_) async => mockOpenPairingWindowResult);

      await check(sut.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      )).completes(it()
        ..has((p0) => p0.manualPairingCode, 'manualPairingCode')
            .equals('manualPairingCode123')
        ..has((p0) => p0.qrCode, 'qrCode').equals('qrCode123'));

      verify(mockFlutterMatterHostApi.openPairingWindowWithPin(
        123,
        180,
        456,
        789,
      ));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostApi.openPairingWindowWithPin(
        any,
        any,
        any,
        any,
      )).thenAnswer((_) async => throw Exception());

      await check(sut.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 456,
        setupPin: 789,
      )).throws();
    });
  });
}
