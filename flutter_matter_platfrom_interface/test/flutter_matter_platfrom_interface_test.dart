import 'package:checks/checks.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_matter_platfrom_interface/src/flutter_matter_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

class ExtendsFlutterMatterPlatform extends FlutterMatterPlatform {}

class ImplementsFlutterMatterPlatform implements FlutterMatterPlatform {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockFlutterMatterPlatform extends FlutterMatterPlatform {
  @override
  Future<String?> getPlatformVersion() async {
    return '42';
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$FlutterMatterPlatform', () {
    test('$MethodChannelFlutterMatter is the default instance', () {
      check(FlutterMatterPlatform.instance).isA<MethodChannelFlutterMatter>();
    });

    test('Cannot be implemented with `implements`', () {
      check(() {
        FlutterMatterPlatform.instance = ImplementsFlutterMatterPlatform();
        // In versions of `package:plugin_platform_interface` prior to fixing
        // https://github.com/flutter/flutter/issues/109339, an attempt to
        // implement a platform interface using `implements` would sometimes
        // throw a `NoSuchMethodError` and other times throw an
        // `AssertionError`.  After the issue is fixed, an `AssertionError` will
        // always be thrown.  For the purpose of this test, we don't really care
        // what exception is thrown, so just allow any exception.
      }).throws();
    });

    test('Can be extended', () {
      FlutterMatterPlatform.instance = ExtendsFlutterMatterPlatform();
    });

    test('Can be mocked with `implements`', () {
      final mock = MockFlutterMatterPlatform();
      FlutterMatterPlatform.instance = mock;
    });

    test(
        'Default implementation of getPlatformVersion should throw unimplemented error',
        () async {
      final flutterMatterPlatform = ExtendsFlutterMatterPlatform();

      await check(flutterMatterPlatform.getPlatformVersion())
          .throws<UnimplementedError>(
              it()..has((p0) => p0.message, 'message').isNotNull());
    });

    test(
        'Default implementation of commission should throw unimplemented error',
        () async {
      final flutterMatterPlatform = ExtendsFlutterMatterPlatform();

      await check(flutterMatterPlatform.commission(deviceId: 123))
          .throws<UnimplementedError>(
              it()..has((p0) => p0.message, 'message').isNotNull());
    });

    test('Default implementation of unpair should throw unimplemented error',
        () async {
      final flutterMatterPlatform = ExtendsFlutterMatterPlatform();

      await check(flutterMatterPlatform.unpair(deviceId: 123))
          .throws<UnimplementedError>(
              it()..has((p0) => p0.message, 'message').isNotNull());
    });

    test('Default implementation of command should throw unimplemented error',
        () async {
      final flutterMatterPlatform = ExtendsFlutterMatterPlatform();

      await check(flutterMatterPlatform.command(
        deviceId: 123,
        endpointId: 1,
        cluster: FlutterMatterCluster.onOff,
        command: FlutterMatterCommand.off,
      )).throws<UnimplementedError>(
          it()..has((p0) => p0.message, 'message').isNotNull());
    });
  });
}
