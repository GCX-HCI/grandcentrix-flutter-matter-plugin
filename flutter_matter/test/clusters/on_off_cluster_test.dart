import 'package:checks/checks.dart';
import 'package:flutter_matter/src/clusters/on_off_cluster.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_off_cluster_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterMatterPlatform>(),
  MockSpec<FlutterMatterOnOffClusterInterface>(),
])
void main() {
  late OnOffCluster sut;

  late MockFlutterMatterPlatform mockFlutterMatterPlatform;
  late MockFlutterMatterOnOffClusterInterface
      mockFlutterMatterOnOffClusterInterface;

  setUp(() {
    mockFlutterMatterPlatform = MockFlutterMatterPlatform();
    mockFlutterMatterOnOffClusterInterface =
        MockFlutterMatterOnOffClusterInterface();

    sut = OnOffCluster();

    FlutterMatterPlatform.skipVerifyForTesting = true;
    FlutterMatterPlatform.instance = mockFlutterMatterPlatform;

    when(mockFlutterMatterPlatform.onOffCluster)
        .thenReturn(mockFlutterMatterOnOffClusterInterface);
  });

  group('commands', () {
    group('off', () {
      test('should call command off', () async {
        await check(sut.off(deviceId: 123, endpointId: 1)).completes();

        verify(mockFlutterMatterOnOffClusterInterface.off(
            deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterOnOffClusterInterface.off(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.off(deviceId: 123, endpointId: 1)).throws();

        verify(mockFlutterMatterOnOffClusterInterface.off(
            deviceId: 123, endpointId: 1));
      });
    });

    group('on', () {
      test('should call command on', () async {
        await check(sut.on(deviceId: 123, endpointId: 1)).completes();

        verify(mockFlutterMatterOnOffClusterInterface.on(
            deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterOnOffClusterInterface.on(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.on(deviceId: 123, endpointId: 1)).throws();

        verify(mockFlutterMatterOnOffClusterInterface.on(
            deviceId: 123, endpointId: 1));
      });
    });

    group('toggle', () {
      test('should call command toggle', () async {
        await check(sut.toggle(deviceId: 123, endpointId: 1)).completes();

        verify(mockFlutterMatterOnOffClusterInterface.toggle(
            deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterOnOffClusterInterface.toggle(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.toggle(deviceId: 123, endpointId: 1)).throws();

        verify(mockFlutterMatterOnOffClusterInterface.toggle(
            deviceId: 123, endpointId: 1));
      });
    });
  });

  group('attributes', () {
    group('readOnOff', () {
      test('should return attribute', () async {
        when(mockFlutterMatterOnOffClusterInterface.readOnOff(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => true);

        await check(sut.readOnOff(deviceId: 123, endpointId: 1))
            .completes(it()..isTrue());

        verify(mockFlutterMatterOnOffClusterInterface.readOnOff(
            deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterOnOffClusterInterface.readOnOff(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.readOnOff(deviceId: 123, endpointId: 1)).throws();

        verify(mockFlutterMatterOnOffClusterInterface.readOnOff(
            deviceId: 123, endpointId: 1));
      });
    });
  });
}
