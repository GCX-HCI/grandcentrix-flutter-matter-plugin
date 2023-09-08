import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/flutter_matter.g.dart',
  kotlinOptions: KotlinOptions(package: 'net.grandcentrix.flutter_matter'),
  kotlinOut:
      'android/src/main/kotlin/net/grandcentrix/flutter_matter/FlutterMatter.g.kt',
  // copyrightHeader: 'pigeons/copyright.txt',
))
@HostApi()
abstract class FlutterMatterHostApi {
  @async
  String getPlatformVersion();
}
