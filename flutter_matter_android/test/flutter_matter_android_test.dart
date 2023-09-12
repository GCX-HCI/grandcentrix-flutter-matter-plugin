import 'package:checks/checks.dart';
import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_matter_android/flutter_matter_android.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './flutter_matter_android_test.mocks.dart';

@GenerateMocks([
  FlutterMatterHostApi,
  MatterDevice,
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

  test(
      '$FlutterMatterAndroid.registerWith sets $FlutterMatterAndroid as instance',
      () {
    FlutterMatterAndroid.registerWith();
    check(FlutterMatterPlatform.instance).isA<FlutterMatterAndroid>();
  });

  test('getPlatformVersion', () async {
    final sut =
        FlutterMatterAndroid(flutterMatterHostApi: mockFlutterMatterHostApi);
    await check(sut.getPlatformVersion()).completes(it()..equals('42'));
  });

  test('commission', () async {
    final sut =
        FlutterMatterAndroid(flutterMatterHostApi: mockFlutterMatterHostApi);

    await check(sut.commission(deviceId: 123))
        .completes(it()..equals(FlutterMatterDevice(id: 123)));
  });
}
