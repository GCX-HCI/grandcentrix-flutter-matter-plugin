import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Extensions for MatterDevice
extension MatterDeviceTransformationExtension on MatterDevice {
  /// Transfrom MatterDevice to FlutterMatterDevice
  FlutterMatterDevice toFlutterMatterDevice() {
    return FlutterMatterDevice(id: id);
  }
}
