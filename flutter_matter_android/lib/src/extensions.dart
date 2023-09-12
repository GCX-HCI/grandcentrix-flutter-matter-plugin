import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Extensions for MatterDevice from Android implementation
extension TransformationExtension on MatterDevice {
  /// Transfrom MatterDevice from Android implementation to FlutterMatterDevice
  FlutterMatterDevice toFlutterMatterDevice() {
    return FlutterMatterDevice(id: id);
  }
}
