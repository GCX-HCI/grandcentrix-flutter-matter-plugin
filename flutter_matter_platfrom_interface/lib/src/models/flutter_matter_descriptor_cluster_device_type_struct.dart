/// Flutter implementation of the DescriptorClusterDeviceTypeStruct
///
/// The device type and revision define endpoint conformance to a release of a device type definition. See the Data Model specification for more information.
class FlutterMatterDescriptorClusterDeviceTypeStruct {
  /// This SHALL indicate the device type definition. The endpoint SHALL conform to the device type def­inition and cluster specifications required by the device type.
  final int deviceType;

  /// This is the implemented revision of the device type definition. The endpoint SHALL conform to this revision of the device type.
  final int revision;

  /// Create DescriptorClusterDeviceTypeStruct
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
