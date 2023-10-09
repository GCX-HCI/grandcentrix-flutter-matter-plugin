import 'package:checks/checks.dart';
import 'package:flutter_matter_android/src/extensions/descriptor_cluster_device_type_struct_transformation_extension.dart';
import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'toFlutterMatterDescriptorClusterDeviceTypeStruct should return correct values',
      () {
    final matterDevice =
        DescriptorClusterDeviceTypeStruct(deviceType: 123, revision: 321);
    final sut = matterDevice.toFlutterMatterDescriptorClusterDeviceTypeStruct();

    check(sut)
      ..has((p0) => p0.deviceType, 'deviceType').equals(123)
      ..has((p0) => p0.revision, 'revision').equals(321);
  });
}
