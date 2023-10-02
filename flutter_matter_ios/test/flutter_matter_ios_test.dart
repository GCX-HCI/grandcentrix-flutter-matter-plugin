import 'package:checks/checks.dart';
import 'package:flutter_matter_ios/flutter_matter_ios.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './flutter_matter_ios_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterMatterHostApi>(),
  MockSpec<MatterDevice>(),
])
void main() {
  late MockMatterDevice mockMatterDevice;
  late MockFlutterMatterHostApi mockFlutterMatterHostApi;

  setUp(() {
    mockMatterDevice = MockMatterDevice();
    mockFlutterMatterHostApi = MockFlutterMatterHostApi();

    when(mockMatterDevice.id).thenReturn(123);

    when(mockFlutterMatterHostApi.getPlatformVersion())
        .thenAnswer((realInvocation) async => '42');
    when(mockFlutterMatterHostApi.commission(any))
        .thenAnswer((realInvocation) async => mockMatterDevice);
  });

  test('$FlutterMatterIos.registerWith sets $FlutterMatterIos as instance', () {
    FlutterMatterIos.registerWith();
    check(FlutterMatterPlatform.instance).isA<FlutterMatterIos>();
  });

  test('getPlatformVersion', () async {
    final sut =
        FlutterMatterIos(flutterMatterHostApi: mockFlutterMatterHostApi);
    await check(sut.getPlatformVersion()).completes(it()..equals('42'));
  });

  test('commission', () async {
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
