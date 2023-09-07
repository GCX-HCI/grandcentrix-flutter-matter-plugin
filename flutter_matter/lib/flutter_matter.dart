import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

class FlutterMatter {
  Future<String?> getPlatformVersion() {
    return FlutterMatterPlatform.instance.getPlatformVersion();
  }
}
