import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Extensions for OpenPairingWindowResult
extension OpenPairingWindowResultTransformationExtension
    on OpenPairingWindowResult {
  /// Transfrom OpenPairingWindowResult to FlutterMatterOpenPairingWindowResult
  FlutterMatterOpenPairingWindowResult
      toFlutterMatterOpenPairingWindowResult() {
    return FlutterMatterOpenPairingWindowResult(
        manualPairingCode: manualPairingCode, qrCode: qrCode);
  }
}
