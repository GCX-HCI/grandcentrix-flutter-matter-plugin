import 'package:checks/checks.dart';
import 'package:flutter_matter_ios/src/clusters/flutter_matter_ios_onoff_cluster.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_matter_ios_onoff_cluster_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterMatterHostOnOffClusterApi>(),
])
void main() {
  late FlutterMatterIosOnOffCluster sut;

  late MockFlutterMatterHostOnOffClusterApi
      mockFlutterMatterHostOnOffClusterApi;

  setUp(() {
    mockFlutterMatterHostOnOffClusterApi =
        MockFlutterMatterHostOnOffClusterApi();

    sut = FlutterMatterIosOnOffCluster(
        flutterMatterHostOnOffClusterApi: mockFlutterMatterHostOnOffClusterApi);
  });

  group('off', () {
    test('should call host api', () async {
      await check(sut.off(deviceId: 123, endpointId: 1)).completes();

      verify(mockFlutterMatterHostOnOffClusterApi.off(123, 1));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostOnOffClusterApi.off(123, 1))
          .thenAnswer((_) async => throw Exception());

      await check(sut.off(deviceId: 123, endpointId: 1)).throws();
    });
  });

  group('on', () {
    test('should call host api', () async {
      await check(sut.on(deviceId: 123, endpointId: 1)).completes();

      verify(mockFlutterMatterHostOnOffClusterApi.on(123, 1));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostOnOffClusterApi.on(123, 1))
          .thenAnswer((_) async => throw Exception());

      await check(sut.on(deviceId: 123, endpointId: 1)).throws();
    });
  });

  group('toggle', () {
    test('should call host api', () async {
      await check(sut.toggle(deviceId: 123, endpointId: 1)).completes();

      verify(mockFlutterMatterHostOnOffClusterApi.toggle(123, 1));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostOnOffClusterApi.toggle(123, 1))
          .thenAnswer((_) async => throw Exception());

      await check(sut.toggle(deviceId: 123, endpointId: 1)).throws();
    });
  });

  group('readOnOff', () {
    test('should call host api', () async {
      when(mockFlutterMatterHostOnOffClusterApi.readOnOff(123, 1))
          .thenAnswer((_) async => true);

      await check(sut.readOnOff(deviceId: 123, endpointId: 1))
          .completes(it()..isTrue());

      verify(mockFlutterMatterHostOnOffClusterApi.readOnOff(123, 1));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostOnOffClusterApi.readOnOff(123, 1))
          .thenAnswer((_) async => throw Exception());

      await check(sut.readOnOff(deviceId: 123, endpointId: 1)).throws();
    });
  });
}
