/// Result of the newly comissoned device
class FlutterMatterDevice {
  /// ID of the device, should be the same, as specified by the commisson method
  final int id;
  // final String name;
  // final int vendorId;
  // final int productId;

  /// Create instance, needs [id]
  FlutterMatterDevice({required this.id});

  @override
  String toString() {
    return 'FlutterMatterDevice(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FlutterMatterDevice &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);
}
