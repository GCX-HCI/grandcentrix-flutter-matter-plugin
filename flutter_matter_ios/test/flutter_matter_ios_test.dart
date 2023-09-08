import 'package:checks/checks.dart';
import 'package:flutter_matter_ios/flutter_matter_ios.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './flutter_matter_ios_test.mocks.dart';

@GenerateMocks([FlutterMatterHostApi])
void main() {
  late MockFlutterMatterHostApi mockFlutterMatterHostApi;

  setUp(() {
    mockFlutterMatterHostApi = MockFlutterMatterHostApi();

    when(mockFlutterMatterHostApi.getPlatformVersion())
        .thenAnswer((realInvocation) async => '42');
  });

  test('$FlutterMatterIos.registerWith sets $FlutterMatterIos as instance', () {
    FlutterMatterIos.registerWith();
    check(FlutterMatterPlatform.instance).isA<FlutterMatterIos>();
  });

  test('getPlatformVersion', () async {
    final sut =
        FlutterMatterIos(flutterMatterHostApi: mockFlutterMatterHostApi);
    await check(sut.getPlatformVersion()).completes(it()..equals('42'));
  });
}
