/// Result of the open pairing window method
class FlutterMatterOpenPairingWindowResult {
  /// Pairing code for manual comisson
  final String? manualPairingCode;

  /// Data for the QrCode
  final String? qrCode;

  /// Create instance of FlutterMatterOpenPairingWindowResult
  FlutterMatterOpenPairingWindowResult({
    required this.manualPairingCode,
    required this.qrCode,
  });

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FlutterMatterOpenPairingWindowResult &&
            (identical(other.manualPairingCode, manualPairingCode) ||
                other.qrCode == qrCode));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        manualPairingCode,
        qrCode,
      );
}
