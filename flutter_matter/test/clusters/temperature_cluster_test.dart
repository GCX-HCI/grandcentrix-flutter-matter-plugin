import 'package:checks/checks.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matter/src/clusters/temperature_cluster.dart';
import 'package:flutter_matter/src/exceptions/flutter_matter_exceptions.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'temperature_cluster_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterMatterTemperatureClusterInterface>(),
])
void main() {
  late TemperatureCluster sut;

  late MockFlutterMatterTemperatureClusterInterface
      mockFlutterMatterTemperatureClusterInterface;

  setUp(() {
    mockFlutterMatterTemperatureClusterInterface =
        MockFlutterMatterTemperatureClusterInterface();

    sut = TemperatureCluster(mockFlutterMatterTemperatureClusterInterface);
  });

  group('attributes', () {
    group('readMaxMeasuredValue', () {
      test('should return attribute', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readMaxMeasuredValue(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => 123);

        await check(sut.readMaxMeasuredValue(deviceId: 123, endpointId: 1))
            .completes(it()..equals(123));

        verify(mockFlutterMatterTemperatureClusterInterface
            .readMaxMeasuredValue(deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readMaxMeasuredValue(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.readMaxMeasuredValue(deviceId: 123, endpointId: 1))
            .throws();

        verify(mockFlutterMatterTemperatureClusterInterface
            .readMaxMeasuredValue(deviceId: 123, endpointId: 1));
      });

      test('should transform PlatformException', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readMaxMeasuredValue(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw PlatformException(code: '-1'));

        await check(sut.readMaxMeasuredValue(deviceId: 123, endpointId: 1))
            .throws<GeneralException>();
      });
    });

    group('readMeasuredValue', () {
      test('should return attribute', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readMeasuredValue(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => 123);

        await check(sut.readMeasuredValue(deviceId: 123, endpointId: 1))
            .completes(it()..equals(123));

        verify(mockFlutterMatterTemperatureClusterInterface.readMeasuredValue(
            deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readMeasuredValue(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.readMeasuredValue(deviceId: 123, endpointId: 1))
            .throws();

        verify(mockFlutterMatterTemperatureClusterInterface.readMeasuredValue(
            deviceId: 123, endpointId: 1));
      });

      test('should transform PlatformException', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readMeasuredValue(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw PlatformException(code: '-1'));

        await check(sut.readMeasuredValue(deviceId: 123, endpointId: 1))
            .throws<GeneralException>();
      });
    });

    group('readMinMeasuredValue', () {
      test('should return attribute', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readMinMeasuredValue(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => 123);

        await check(sut.readMinMeasuredValue(deviceId: 123, endpointId: 1))
            .completes(it()..equals(123));

        verify(mockFlutterMatterTemperatureClusterInterface
            .readMinMeasuredValue(deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readMinMeasuredValue(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.readMinMeasuredValue(deviceId: 123, endpointId: 1))
            .throws();

        verify(mockFlutterMatterTemperatureClusterInterface
            .readMinMeasuredValue(deviceId: 123, endpointId: 1));
      });

      test('should transform PlatformException', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readMinMeasuredValue(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw PlatformException(code: '-1'));

        await check(sut.readMinMeasuredValue(deviceId: 123, endpointId: 1))
            .throws<GeneralException>();
      });
    });

    group('readTolerance', () {
      test('should return attribute', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readTolerance(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => 123);

        await check(sut.readTolerance(deviceId: 123, endpointId: 1))
            .completes(it()..equals(123));

        verify(mockFlutterMatterTemperatureClusterInterface.readTolerance(
            deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readTolerance(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.readTolerance(deviceId: 123, endpointId: 1)).throws();

        verify(mockFlutterMatterTemperatureClusterInterface.readTolerance(
            deviceId: 123, endpointId: 1));
      });

      test('should transform PlatformException', () async {
        when(mockFlutterMatterTemperatureClusterInterface.readTolerance(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw PlatformException(code: '-1'));

        await check(sut.readTolerance(deviceId: 123, endpointId: 1))
            .throws<GeneralException>();
      });
    });
  });
}
