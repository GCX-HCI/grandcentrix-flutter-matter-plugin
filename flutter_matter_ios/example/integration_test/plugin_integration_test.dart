// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://docs.flutter.dev/cookbook/testing/integration/introduction

import 'package:checks/checks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_matter_ios/flutter_matter_ios.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getPlatformVersion test', (WidgetTester tester) async {
    final FlutterMatterIos plugin = await FlutterMatterIos.createInstance(
      appGroup: 'group.example.flutterMatterExample',
      ecoSystemName: 'testEcoSystemName',
      fabricId: 1,
      vendorId: 0xFFF1, // Test Vendor ID
    );
    await check(plugin.getPlatformVersion()).completes(
      it()..isNotNull().isNotEmpty(),
    );
  });
}
