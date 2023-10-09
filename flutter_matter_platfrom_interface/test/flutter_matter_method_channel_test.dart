import 'package:checks/checks.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matter_platfrom_interface/src/flutter_matter_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_matter');

  late MethodChannelFlutterMatter platform = MethodChannelFlutterMatter();

  TestWidgetsFlutterBinding.ensureInitialized();

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

  test('getPlatformVersion', () async {
    await check(platform.getPlatformVersion()).completes(it()..equals('42'));
  });
}
