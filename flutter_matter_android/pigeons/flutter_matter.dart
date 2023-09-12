import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/flutter_matter.g.dart',
  kotlinOptions: KotlinOptions(package: 'net.grandcentrix.flutter_matter'),
  kotlinOut:
      'android/src/main/kotlin/net/grandcentrix/flutter_matter/FlutterMatter.g.kt',
  // copyrightHeader: 'pigeons/copyright.txt',
))
class MatterDevice {
  final int id;
  // final String deviceName;
  // final int vendorId;
  // final int productId;

  MatterDevice({required this.id});
}

class CommissionRequest {
  final int id;

  CommissionRequest({required this.id});
}

@HostApi()
abstract class FlutterMatterHostApi {
  @async
  String getPlatformVersion();

  @async
  MatterDevice commission(CommissionRequest request);
}
