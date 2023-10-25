import 'package:checks/checks.dart';
import 'package:flutter_matter_android/src/clusters/flutter_matter_android_temperature_cluster.dart';
import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_matter_android_temperature_cluster_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterMatterHostTemperatureClusterApi>(),
])
void main() {
  late FlutterMatterAndroidTemperatureCluster sut;

  late MockFlutterMatterHostTemperatureClusterApi
      mockFlutterMatterHostTemperatureClusterApi;

  setUp(() {
    mockFlutterMatterHostTemperatureClusterApi =
        MockFlutterMatterHostTemperatureClusterApi();

    sut = FlutterMatterAndroidTemperatureCluster(
        flutterMatterHostTemperatureClusterApi:
            mockFlutterMatterHostTemperatureClusterApi);
  });

  group('readMaxMeasuredValue', () {
    test('should call host api', () async {
      when(mockFlutterMatterHostTemperatureClusterApi.readMaxMeasuredValue(
              123, 1))
          .thenAnswer((_) async => 123);

      await check(sut.readMaxMeasuredValue(deviceId: 123, endpointId: 1))
          .completes(it()..equals(123));

      verify(mockFlutterMatterHostTemperatureClusterApi.readMaxMeasuredValue(
          123, 1));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostTemperatureClusterApi.readMaxMeasuredValue(
              123, 1))
          .thenAnswer((_) async => throw Exception());

      await check(sut.readMaxMeasuredValue(deviceId: 123, endpointId: 1))
          .throws();
    });
  });

  group('readMeasuredValue', () {
    test('should call host api', () async {
      when(mockFlutterMatterHostTemperatureClusterApi.readMeasuredValue(123, 1))
          .thenAnswer((_) async => 123);

      await check(sut.readMeasuredValue(deviceId: 123, endpointId: 1))
          .completes(it()..equals(123));

      verify(
          mockFlutterMatterHostTemperatureClusterApi.readMeasuredValue(123, 1));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostTemperatureClusterApi.readMeasuredValue(123, 1))
          .thenAnswer((_) async => throw Exception());

      await check(sut.readMeasuredValue(deviceId: 123, endpointId: 1)).throws();
    });
  });

  group('readMinMeasuredValue', () {
    test('should call host api', () async {
      when(mockFlutterMatterHostTemperatureClusterApi.readMinMeasuredValue(
              123, 1))
          .thenAnswer((_) async => 123);

      await check(sut.readMinMeasuredValue(deviceId: 123, endpointId: 1))
          .completes(it()..equals(123));

      verify(mockFlutterMatterHostTemperatureClusterApi.readMinMeasuredValue(
          123, 1));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostTemperatureClusterApi.readMinMeasuredValue(
              123, 1))
          .thenAnswer((_) async => throw Exception());

      await check(sut.readMinMeasuredValue(deviceId: 123, endpointId: 1))
          .throws();
    });
  });

  group('readTolerance', () {
    test('should call host api', () async {
      when(mockFlutterMatterHostTemperatureClusterApi.readTolerance(123, 1))
          .thenAnswer((_) async => 123);

      await check(sut.readTolerance(deviceId: 123, endpointId: 1))
          .completes(it()..equals(123));

      verify(mockFlutterMatterHostTemperatureClusterApi.readTolerance(123, 1));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostTemperatureClusterApi.readTolerance(123, 1))
          .thenAnswer((_) async => throw Exception());

      await check(sut.readTolerance(deviceId: 123, endpointId: 1)).throws();
    });
  });
}
