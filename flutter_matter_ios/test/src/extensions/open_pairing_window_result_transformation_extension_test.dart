import 'package:checks/checks.dart';
import 'package:flutter_matter_ios/src/extensions/open_pairing_window_result_transformation_extension.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toFlutterMatterOpenPairingWindowResult should return connrect values',
      () {
    check(
        OpenPairingWindowResult(manualPairingCode: '1234', qrCode: 'qrCode123')
            .toFlutterMatterOpenPairingWindowResult())
      ..has((p0) => p0.manualPairingCode, 'manualPairingCode').equals('1234')
      ..has((p0) => p0.qrCode, 'qrCode').equals('qrCode123');
  });
}
