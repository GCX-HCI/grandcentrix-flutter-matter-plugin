import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/flutter_matter.g.dart',
  kotlinOptions: KotlinOptions(package: 'net.grandcentrix.flutter_matter'),
  kotlinOut:
      'android/src/main/kotlin/net/grandcentrix/flutter_matter/FlutterMatter.g.kt',
  // copyrightHeader: 'pigeons/copyright.txt',
))
@HostApi()
abstract class FlutterMatterHostOnOffClusterApi {
  @async
  void off(
    int deviceId,
    int endpointId,
  );

  @async
  void on(
    int deviceId,
    int endpointId,
  );

  @async
  void toggle(
    int deviceId,
    int endpointId,
  );

  @async
  bool readOnOff(
    int deviceId,
    int endpointId,
  );

  @async
  void subscribeToOnOff(
    int deviceId,
    int endpointId,
  );

  @async
  void unsubscribeToOnOff(
    int deviceId,
    int endpointId,
  );
}

class AndroidError {
  /// Creates a [PlatformException] with the specified error [code] and optional
  /// [message], and with the optional error [details] which must be a valid
  /// value for the [MethodCodec] involved in the interaction.
  AndroidError({
    required this.code,
    this.message,
  });

  /// An error code.
  final String code;

  /// A human-readable error message, possibly null.
  final String? message;
}

@FlutterApi()
abstract class FlutterMatterFlutterOnOffClusterApi {
  void onOff(
    int deviceId,
    int endpointId,
    bool? onOff,
    AndroidError? error,
  );
}

class DescriptorClusterDeviceTypeStruct {
  final int deviceType;
  final int revision;

  DescriptorClusterDeviceTypeStruct({
    required this.deviceType,
    required this.revision,
  });
}

@HostApi()
abstract class FlutterMatterHostDescriptorClusterApi {
  @async
  List<DescriptorClusterDeviceTypeStruct> readDeviceTypeList(
    int deviceId,
    int endpointId,
  );

  @async
  List<int> readServerList(
    int deviceId,
    int endpointId,
  );

  @async
  List<int> readClientList(
    int deviceId,
    int endpointId,
  );

  @async
  List<int> readPartsList(
    int deviceId,
    int endpointId,
  );

  // @async
  // List<int> readGeneratedCommandList(int deviceId);

  // @async
  // List<int> readAcceptedCommandList(int deviceId);

  // @async
  // List<int> readEventList(int deviceId);

  // @async
  // List<int> readAttributeList(int deviceId);

  // @async
  // List<int> readFeatureMap(int deviceId);

  // @async
  // List<int> readClusterRevision(int deviceId);
}

class MatterDevice {
  final int id;
  // final String deviceName;
  // final int vendorId;
  // final int productId;

  MatterDevice({required this.id});
}

class CommissionRequest {
  final int id;

  CommissionRequest({required this.id});
}

class OpenPairingWindowResult {
  final String? manualPairingCode;
  final String? qrCode;

  OpenPairingWindowResult({
    required this.manualPairingCode,
    required this.qrCode,
  });
}

@HostApi()
abstract class FlutterMatterHostApi {
  @async
  String getPlatformVersion();

  @async
  MatterDevice commission(CommissionRequest request);

  @async
  void unpair(int deviceId);

  @async
  OpenPairingWindowResult openPairingWindowWithPin(
    int deviceId,
    int duration,
    int discriminator,
    int setupPin,
  );
}
