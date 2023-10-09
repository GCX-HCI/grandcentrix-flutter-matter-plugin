class FlutterMatterDescriptorClusterDeviceTypeStruct {
  final int deviceType;
  final int revision;

  FlutterMatterDescriptorClusterDeviceTypeStruct({
    required this.deviceType,
    required this.revision,
  });

  @override
  String toString() =>
      'DeviceType: 0x${deviceType.toRadixString(16).padLeft(4, '0')} Revision: $revision';

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FlutterMatterDescriptorClusterDeviceTypeStruct &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.revision, revision) ||
                other.revision == revision));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        deviceType,
        revision,
      );
}
