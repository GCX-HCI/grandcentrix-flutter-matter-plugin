import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

extension DescriptorClusterDeviceTypeStructTransformationExtension
    on DescriptorClusterDeviceTypeStruct {
  FlutterMatterDescriptorClusterDeviceTypeStruct
      toFlutterMatterDescriptorClusterDeviceTypeStruct() {
    return FlutterMatterDescriptorClusterDeviceTypeStruct(
        deviceType: deviceType, revision: revision);
  }
}
