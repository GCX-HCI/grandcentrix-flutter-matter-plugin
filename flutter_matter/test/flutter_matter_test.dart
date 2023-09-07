import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_matter/flutter_matter.dart';
import 'package:mockito/mockito.dart';
import 'package:checks/checks.dart';

class MockFlutterMatterPlatform extends FlutterMatterPlatform {
  @override
  Future<String?> getPlatformVersion() async {
    return '42';
  }
}

void main() {
  final FlutterMatterPlatform initialPlatform = FlutterMatterPlatform.instance;

  test('$FlutterMatterPlatform is the default instance', () {
    check(initialPlatform).isA<FlutterMatterPlatform>();
  });

  test('getPlatformVersion', () async {
    final flutterMatterPlugin = FlutterMatter();
    final fakePlatform = MockFlutterMatterPlatform();
    FlutterMatterPlatform.instance = fakePlatform;

    await check(flutterMatterPlugin.getPlatformVersion())
        .completes(it()..equals('42'));
  });
}
