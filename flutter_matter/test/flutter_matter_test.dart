import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_matter/src/flutter_matter.dart';
import 'package:checks/checks.dart';

import 'flutter_matter_platfrom_test_impl.dart';

void main() {
  late FlutterMatterPlatformTestImpl mockFlutterMatterPlatformTestImpl;

  setUp(() {
    mockFlutterMatterPlatformTestImpl = FlutterMatterPlatformTestImpl();

    FlutterMatterPlatform.instance = mockFlutterMatterPlatformTestImpl;
  });

  test('getPlatformVersion', () async {
    final sut = FlutterMatter();

    mockFlutterMatterPlatformTestImpl.getPlatformVersionReturnValue = '42';

    await check(sut.getPlatformVersion()).completes(it()..equals('42'));
  });
}
