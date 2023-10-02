import 'package:checks/checks.dart';
import 'package:flutter_matter/src/on_off_cluster.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'flutter_matter_platfrom_test_impl.dart';

@GenerateMocks([
  FlutterMatterDevice,
])
void main() {
  late FlutterMatterPlatformTestImpl mockFlutterMatterPlatformTestImpl;

  setUp(() {
    mockFlutterMatterPlatformTestImpl = FlutterMatterPlatformTestImpl();

    FlutterMatterPlatform.instance = mockFlutterMatterPlatformTestImpl;
  });

  test('off', () async {
    final sut = OnOffCluster();

    await check(sut.off(deviceId: 123, endpointId: 321)).completes();
    check(mockFlutterMatterPlatformTestImpl)
      ..has((value) => value.commandParamterDeviceId, 'commandParamterDeviceId')
          .equals(123)
      ..has((value) => value.commandParamterEndpointId,
              'commandParamterEndpointId')
          .equals(321)
      ..has((value) => value.commandParamterCluster, 'commandParamterCluster')
          .equals(FlutterMatterCluster.onOff)
      ..has((value) => value.commandParamterCommand, 'commandParamterCommand')
          .equals(FlutterMatterCommand.off);
  });

  test('on', () async {
    final sut = OnOffCluster();

    await check(sut.on(deviceId: 123, endpointId: 321)).completes();
    check(mockFlutterMatterPlatformTestImpl)
      ..has((value) => value.commandParamterDeviceId, 'commandParamterDeviceId')
          .equals(123)
      ..has((value) => value.commandParamterEndpointId,
              'commandParamterEndpointId')
          .equals(321)
      ..has((value) => value.commandParamterCluster, 'commandParamterCluster')
          .equals(FlutterMatterCluster.onOff)
      ..has((value) => value.commandParamterCommand, 'commandParamterCommand')
          .equals(FlutterMatterCommand.on);
  });

  test('toggle', () async {
    final sut = OnOffCluster();

    await check(sut.toggle(deviceId: 123, endpointId: 321)).completes();
    check(mockFlutterMatterPlatformTestImpl)
      ..has((value) => value.commandParamterDeviceId, 'commandParamterDeviceId')
          .equals(123)
      ..has((value) => value.commandParamterEndpointId,
              'commandParamterEndpointId')
          .equals(321)
      ..has((value) => value.commandParamterCluster, 'commandParamterCluster')
          .equals(FlutterMatterCluster.onOff)
      ..has((value) => value.commandParamterCommand, 'commandParamterCommand')
          .equals(FlutterMatterCommand.toggle);
  });
}
