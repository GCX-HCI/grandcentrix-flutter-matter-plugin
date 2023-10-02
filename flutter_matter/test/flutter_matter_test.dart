import 'package:flutter_matter/src/on_off_cluster.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_matter/src/flutter_matter.dart';
import 'package:checks/checks.dart';
import 'package:mockito/annotations.dart';

import 'flutter_matter_platfrom_test_impl.dart';
import 'flutter_matter_test.mocks.dart';

@GenerateMocks([FlutterMatterDevice])
void main() {
  late FlutterMatterPlatformTestImpl mockFlutterMatterPlatformTestImpl;

  late MockFlutterMatterDevice mockFlutterMatterDevice;

  setUp(() {
    mockFlutterMatterPlatformTestImpl = FlutterMatterPlatformTestImpl();
    mockFlutterMatterDevice = MockFlutterMatterDevice();

    FlutterMatterPlatform.instance = mockFlutterMatterPlatformTestImpl;
  });

  test('getPlatformVersion', () async {
    final sut = FlutterMatter();

    mockFlutterMatterPlatformTestImpl.getPlatformVersionReturnValue = '42';

    await check(sut.getPlatformVersion()).completes(it()..equals('42'));
  });

  test('commission', () async {
    final sut = FlutterMatter();

    mockFlutterMatterPlatformTestImpl.commissonReturnValue =
        mockFlutterMatterDevice;

    await check(sut.commission(deviceId: 123))
        .completes(it()..equals(mockFlutterMatterDevice));

    check(mockFlutterMatterPlatformTestImpl.commissonParamterDeviceId)
        .equals(123);
  });

  test('unpair', () async {
    final sut = FlutterMatter();

    await check(sut.unpair(deviceId: 123)).completes();

    check(mockFlutterMatterPlatformTestImpl.unpairParamterDeviceId).equals(123);
  });

  test('onOffCluster', () async {
    final sut = FlutterMatter();

    check(sut.onOffCluster)
      ..isNotNull()
      ..isA<OnOffCluster>();
  });
}
