import 'package:checks/checks.dart';
import 'package:flutter_matter_ios/src/extensions/matter_device_transformation_extension.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toFlutterMatterDevice should return correct values', () {
    final matterDevice = MatterDevice(id: 123);
    final sut = matterDevice.toFlutterMatterDevice();

    check(sut).has((p0) => p0.id, 'id').equals(123);
  });
}
