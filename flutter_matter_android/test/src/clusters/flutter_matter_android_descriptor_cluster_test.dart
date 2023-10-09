import 'package:checks/checks.dart';
import 'package:flutter_matter_android/src/clusters/flutter_matter_android_descriptor_cluster.dart';
import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_matter_android_descriptor_cluster_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterMatterHostDescriptorClusterApi>(),
])
void main() {
  late FlutterMatterAndroidDescriptorCluster sut;

  late MockFlutterMatterHostDescriptorClusterApi
      mockFlutterMatterHostDescriptorClusterApi;

  setUp(() {
    mockFlutterMatterHostDescriptorClusterApi =
        MockFlutterMatterHostDescriptorClusterApi();

    sut = FlutterMatterAndroidDescriptorCluster(
        flutterMatterHostDescriptorClusterApi:
            mockFlutterMatterHostDescriptorClusterApi);
  });

  group('readClientList', () {
    test('should call host api', () async {
      final expectedResult = <int>[1, 2, 3];
      when(mockFlutterMatterHostDescriptorClusterApi.readClientList(123, 1))
          .thenAnswer((_) async => expectedResult);

      await check(sut.readClientList(deviceId: 123, endpointId: 1))
          .completes(it()..deepEquals(expectedResult));

      verify(mockFlutterMatterHostDescriptorClusterApi.readClientList(123, 1));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostDescriptorClusterApi.readClientList(123, 1))
          .thenAnswer((_) async => throw Exception());

      await check(sut.readClientList(deviceId: 123, endpointId: 1)).throws();
    });
  });

  group('readDeviceTypeList', () {
    test('should call host api', () async {
      final expectedResult = <DescriptorClusterDeviceTypeStruct>[
        DescriptorClusterDeviceTypeStruct(deviceType: 123, revision: 321)
      ];
      when(mockFlutterMatterHostDescriptorClusterApi.readDeviceTypeList(123, 1))
          .thenAnswer((_) async => expectedResult);

      await check(sut.readDeviceTypeList(deviceId: 123, endpointId: 1))
          .completes(
        it()
          ..contains(FlutterMatterDescriptorClusterDeviceTypeStruct(
              deviceType: 123, revision: 321)),
      );

      verify(
          mockFlutterMatterHostDescriptorClusterApi.readDeviceTypeList(123, 1));
    });

    test('should rethrow exceptions', () async {
      when(mockFlutterMatterHostDescriptorClusterApi.readDeviceTypeList(123, 1))
          .thenAnswer((_) async => throw Exception());

      await check(sut.readDeviceTypeList(deviceId: 123, endpointId: 1))
          .throws();
    });
  });
}
