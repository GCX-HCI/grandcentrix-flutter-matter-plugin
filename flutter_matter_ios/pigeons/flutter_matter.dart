import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/flutter_matter.g.dart',
  swiftOptions: SwiftOptions(),
  swiftOut: 'ios/flutter_matter_ios/Classes/FlutterMatter.g.swift',
  // copyrightHeader: 'pigeons/copyright.txt',
))
@HostApi()
abstract class FlutterMatterHostApi {
  @async
  String getPlatformVersion();
}
