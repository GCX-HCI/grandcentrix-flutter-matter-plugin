import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

class FlutterMatterPlatformTestImpl extends FlutterMatterPlatform {
  String? _getPlatformVersionReturnValue;

  set getPlatformVersionReturnValue(String val) =>
      _getPlatformVersionReturnValue = val;

  @override
  Future<String?> getPlatformVersion() {
    return Future.value(_getPlatformVersionReturnValue!);
  }

  int _commissonParamterDeviceId = -1;
  int get commissonParamterDeviceId => _commissonParamterDeviceId;

  FlutterMatterDevice? _commissonReturnValue;
  set commissonReturnValue(FlutterMatterDevice val) =>
      _commissonReturnValue = val;

  @override
  Future<FlutterMatterDevice> commission({required int deviceId}) async {
    _commissonParamterDeviceId = deviceId;
    return Future.value(_commissonReturnValue!);
  }

  int _unpairParamterDeviceId = -1;
  int get unpairParamterDeviceId => _unpairParamterDeviceId;

  @override
  Future<void> unpair({required int deviceId}) async {
    _unpairParamterDeviceId = deviceId;
    return Future.value();
  }

  int _openPairingWindowWithPinDeviceId = -1;
  int get openPairingWindowWithPinDeviceId => _openPairingWindowWithPinDeviceId;

  Duration _openPairingWindowWithPinDuration = const Duration();
  Duration get openPairingWindowWithPinDuration =>
      _openPairingWindowWithPinDuration;

  int _openPairingWindowWithPinDiscriminator = -1;
  int get openPairingWindowWithPinDiscriminator =>
      _openPairingWindowWithPinDiscriminator;

  int _openPairingWindowWithPinSetupPin = -1;
  int get openPairingWindowWithPinSetupPin => _openPairingWindowWithPinSetupPin;

  FlutterMatterOpenPairingWindowResult? _openPairingWindowWithPinReturnValue;
  set openPairingWindowWithPinReturnValue(
          FlutterMatterOpenPairingWindowResult val) =>
      _openPairingWindowWithPinReturnValue = val;

  @override
  Future<FlutterMatterOpenPairingWindowResult> openPairingWindowWithPin({
    required int deviceId,
    required Duration duration,
    required int discriminator,
    required int setupPin,
  }) {
    _openPairingWindowWithPinDeviceId = deviceId;
    _openPairingWindowWithPinDuration = duration;
    _openPairingWindowWithPinDiscriminator = discriminator;
    _openPairingWindowWithPinSetupPin = setupPin;

    return Future.value(_openPairingWindowWithPinReturnValue!);
  }

  int _commandParamterDeviceId = -1;
  int get commandParamterDeviceId => _commandParamterDeviceId;

  int _commandParamterEndpointId = -1;
  int get commandParamterEndpointId => _commandParamterEndpointId;

  FlutterMatterCluster _commandParamterCluster = FlutterMatterCluster.onOff;
  FlutterMatterCluster get commandParamterCluster => _commandParamterCluster;

  FlutterMatterCommand _commandParamterCommand = FlutterMatterCommand.off;
  FlutterMatterCommand get commandParamterCommand => _commandParamterCommand;

  @override
  Future<void> command({
    required int deviceId,
    required int endpointId,
    required FlutterMatterCluster cluster,
    required FlutterMatterCommand command,
  }) {
    _commandParamterDeviceId = deviceId;
    _commandParamterEndpointId = endpointId;
    _commandParamterCluster = cluster;
    _commandParamterCommand = command;

    return Future.value();
  }
}
