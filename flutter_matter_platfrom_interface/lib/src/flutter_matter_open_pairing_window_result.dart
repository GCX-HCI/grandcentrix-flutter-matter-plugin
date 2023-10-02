class FlutterMatterOpenPairingWindowResult {
  final String? manualPairingCode;
  final String? qrCode;

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
