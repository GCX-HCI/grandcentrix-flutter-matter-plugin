import 'package:checks/checks.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_matter_android/flutter_matter_android.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  FlutterMatterAndroid platform = FlutterMatterAndroid();
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

  test(
      '$FlutterMatterAndroid.registerWith sets $FlutterMatterAndroid as instance',
      () {
    FlutterMatterAndroid.registerWith();
    check(FlutterMatterPlatform.instance).isA<FlutterMatterAndroid>();
  });

  test('getPlatformVersion', () async {
    await check(platform.getPlatformVersion()).completes(it()..equals('42'));
  });
}
