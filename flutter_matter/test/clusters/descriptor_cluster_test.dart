import 'package:checks/checks.dart';
import 'package:flutter_matter/src/clusters/descriptor_cluster.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'descriptor_cluster_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterMatterPlatformInterface>(),
  MockSpec<FlutterMatterDescriptorClusterInterface>(),
  MockSpec<FlutterMatterDescriptorClusterDeviceTypeStruct>(),
])
void main() {
  late DescriptorCluster sut;

  late MockFlutterMatterPlatformInterface mockFlutterMatterPlatform;
  late MockFlutterMatterDescriptorClusterInterface
      mockFlutterMatterDescriptorClusterInterface;

  setUp(() {
    mockFlutterMatterPlatform = MockFlutterMatterPlatformInterface();
    mockFlutterMatterDescriptorClusterInterface =
        MockFlutterMatterDescriptorClusterInterface();

    sut = DescriptorCluster(mockFlutterMatterPlatform);

    when(mockFlutterMatterPlatform.descriptorCluster)
        .thenReturn(mockFlutterMatterDescriptorClusterInterface);
  });

  group('attributes', () {
    group('deviceTypeList', () {
      test('should return list of DescriptorClusterDeviceTypeStructs',
          () async {
        final result = List.generate(
            3, (_) => MockFlutterMatterDescriptorClusterDeviceTypeStruct());

        when(mockFlutterMatterDescriptorClusterInterface.readDeviceTypeList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => result);

        await check(sut.deviceTypeList(deviceId: 123, endpointId: 1))
            .completes(it()..deepEquals(result));

        verify(mockFlutterMatterDescriptorClusterInterface.readDeviceTypeList(
            deviceId: 123, endpointId: 1));
      });

      test('should return filter null values out', () async {
        final result = <MockFlutterMatterDescriptorClusterDeviceTypeStruct?>[
          MockFlutterMatterDescriptorClusterDeviceTypeStruct(),
          null,
          MockFlutterMatterDescriptorClusterDeviceTypeStruct()
        ];

        when(mockFlutterMatterDescriptorClusterInterface.readDeviceTypeList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => result);

        await check(sut.deviceTypeList(deviceId: 123, endpointId: 1))
            .completes(it()..has((p0) => p0.length, 'length').equals(2));

        verify(mockFlutterMatterDescriptorClusterInterface.readDeviceTypeList(
            deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterDescriptorClusterInterface.readDeviceTypeList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.deviceTypeList(deviceId: 123, endpointId: 1)).throws();

        verify(mockFlutterMatterDescriptorClusterInterface.readDeviceTypeList(
            deviceId: 123, endpointId: 1));
      });
    });

    group('serverList', () {
      test('should return list of cluster ids', () async {
        final result = List.filled(3, 1);

        when(mockFlutterMatterDescriptorClusterInterface.readServerList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => result);

        await check(sut.serverList(deviceId: 123, endpointId: 1))
            .completes(it()..deepEquals(result));

        verify(mockFlutterMatterDescriptorClusterInterface.readServerList(
            deviceId: 123, endpointId: 1));
      });

      test('should return filter null values out', () async {
        final result = <int?>[123, null, 456];

        when(mockFlutterMatterDescriptorClusterInterface.readServerList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => result);

        await check(sut.serverList(deviceId: 123, endpointId: 1))
            .completes(it()..has((p0) => p0.length, 'length').equals(2));

        verify(mockFlutterMatterDescriptorClusterInterface.readServerList(
            deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterDescriptorClusterInterface.readServerList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.serverList(deviceId: 123, endpointId: 1)).throws();

        verify(mockFlutterMatterDescriptorClusterInterface.readServerList(
            deviceId: 123, endpointId: 1));
      });
    });

    group('clientList', () {
      test('should return list of cluster ids', () async {
        final result = List.filled(3, 1);

        when(mockFlutterMatterDescriptorClusterInterface.readClientList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => result);

        await check(sut.clientList(deviceId: 123, endpointId: 1))
            .completes(it()..deepEquals(result));

        verify(mockFlutterMatterDescriptorClusterInterface.readClientList(
            deviceId: 123, endpointId: 1));
      });

      test('should return filter null values out', () async {
        final result = <int?>[123, null, 456];

        when(mockFlutterMatterDescriptorClusterInterface.readClientList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => result);

        await check(sut.clientList(deviceId: 123, endpointId: 1))
            .completes(it()..has((p0) => p0.length, 'length').equals(2));

        verify(mockFlutterMatterDescriptorClusterInterface.readClientList(
            deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterDescriptorClusterInterface.readClientList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.clientList(deviceId: 123, endpointId: 1)).throws();

        verify(mockFlutterMatterDescriptorClusterInterface.readClientList(
            deviceId: 123, endpointId: 1));
      });
    });

    group('partsList', () {
      test('should return list of device type instances', () async {
        final result = List.filled(3, 1);

        when(mockFlutterMatterDescriptorClusterInterface.readPartsList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => result);

        await check(sut.partsList(deviceId: 123, endpointId: 1))
            .completes(it()..deepEquals(result));

        verify(mockFlutterMatterDescriptorClusterInterface.readPartsList(
            deviceId: 123, endpointId: 1));
      });

      test('should return filter null values out', () async {
        final result = <int?>[123, null, 456];

        when(mockFlutterMatterDescriptorClusterInterface.readPartsList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => result);

        await check(sut.partsList(deviceId: 123, endpointId: 1))
            .completes(it()..has((p0) => p0.length, 'length').equals(2));

        verify(mockFlutterMatterDescriptorClusterInterface.readPartsList(
            deviceId: 123, endpointId: 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterDescriptorClusterInterface.readPartsList(
                deviceId: 123, endpointId: 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.partsList(deviceId: 123, endpointId: 1)).throws();

        verify(mockFlutterMatterDescriptorClusterInterface.readPartsList(
            deviceId: 123, endpointId: 1));
      });
    });
  });
}
