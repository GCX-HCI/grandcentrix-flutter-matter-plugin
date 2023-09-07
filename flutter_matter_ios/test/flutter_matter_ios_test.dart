import 'package:checks/checks.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matter_ios/flutter_matter_ios.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  FlutterMatterIos platform = FlutterMatterIos();
  const MethodChannel channel = MethodChannel('flutter_matter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('$FlutterMatterIos.registerWith sets $FlutterMatterIos as instance', () {
    FlutterMatterIos.registerWith();
    check(FlutterMatterPlatform.instance).isA<FlutterMatterIos>();
  });

  test('getPlatformVersion', () async {
    await check(platform.getPlatformVersion()).completes(it()..equals('42'));
  });
}
