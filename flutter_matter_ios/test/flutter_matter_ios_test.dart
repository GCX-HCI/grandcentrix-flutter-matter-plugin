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
])
void main() {
  late MockFlutterMatterHostApi mockFlutterMatterHostApi;

  setUp(() {
    mockFlutterMatterHostApi = MockFlutterMatterHostApi();
  });

  test('$FlutterMatterIos.registerWith sets $FlutterMatterIos as instance', () {
    FlutterMatterIos.registerWith();
    check(FlutterMatterPlatform.instance).isA<FlutterMatterIos>();
  });

  test('getPlatformVersion', () async {
    when(mockFlutterMatterHostApi.getPlatformVersion())
        .thenAnswer((_) async => '42');

    final sut =
        FlutterMatterIos(flutterMatterHostApi: mockFlutterMatterHostApi);
    await check(sut.getPlatformVersion()).completes(it()..equals('42'));
  });

  test('commission', () async {
    final mockMatterDevice = MockMatterDevice();

    when(mockMatterDevice.id).thenReturn(123);
    when(mockFlutterMatterHostApi.commission(any))
        .thenAnswer((_) async => mockMatterDevice);

    final sut =
        FlutterMatterIos(flutterMatterHostApi: mockFlutterMatterHostApi);

    await check(sut.commission(deviceId: 123))
        .completes(it()..equals(FlutterMatterDevice(id: 123)));
  });

  test('unpair', () async {
    final sut =
        FlutterMatterIos(flutterMatterHostApi: mockFlutterMatterHostApi);

    await check(sut.unpair(deviceId: 123)).completes();

    verify(mockFlutterMatterHostApi.unpair(123));
  });

  test('openPairingWindowWithPin', () async {
    final mockOpenPairingWindowResult = MockOpenPairingWindowResult();

    when(mockOpenPairingWindowResult.manualPairingCode)
        .thenReturn('manualPairingCode123');
    when(mockOpenPairingWindowResult.qrCode).thenReturn('qrCode123');
    when(mockFlutterMatterHostApi.openPairingWindowWithPin(123, 180, 456, 789))
        .thenAnswer((_) async => mockOpenPairingWindowResult);

    final sut =
        FlutterMatterIos(flutterMatterHostApi: mockFlutterMatterHostApi);

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

  test('command', () async {
    final sut =
        FlutterMatterIos(flutterMatterHostApi: mockFlutterMatterHostApi);

    await check(sut.command(
      deviceId: 123,
      endpointId: 1,
      cluster: FlutterMatterCluster.onOff,
      command: FlutterMatterCommand.on,
    )).completes();

    verify(mockFlutterMatterHostApi.command(
      123,
      1,
      Cluster.onOff,
      Command.on,
    ));
  });
}
