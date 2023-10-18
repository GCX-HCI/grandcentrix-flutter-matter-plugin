import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Transformation extension methods for [DescriptorClusterDeviceTypeStruct]
extension DescriptorClusterDeviceTypeStructTransformationExtension
    on DescriptorClusterDeviceTypeStruct {
  /// Transform [DescriptorClusterDeviceTypeStruct] to [FlutterMatterDescriptorClusterDeviceTypeStruct]
  FlutterMatterDescriptorClusterDeviceTypeStruct
      toFlutterMatterDescriptorClusterDeviceTypeStruct() {
    return FlutterMatterDescriptorClusterDeviceTypeStruct(
        deviceType: deviceType, revision: revision);
  }
}
