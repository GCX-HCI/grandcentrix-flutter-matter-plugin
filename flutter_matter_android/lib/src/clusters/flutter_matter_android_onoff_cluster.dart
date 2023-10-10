import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matter_android/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:rxdart/rxdart.dart';

/// Attributes and commands for turning devices on and off
final class FlutterMatterAndroidOnOffCluster
    implements
        FlutterMatterOnOffClusterInterface,
        FlutterMatterFlutterOnOffClusterApi {
  final FlutterMatterHostOnOffClusterApi _flutterMatterHostOnOffClusterApi;

  final _onOffSubscriptions = <(int, int), Subject<bool>>{};

  /// Creates a new OnOff cluster implementation instance.
  FlutterMatterAndroidOnOffCluster({
    @visibleForTesting
    FlutterMatterHostOnOffClusterApi? flutterMatterHostOnOffClusterApi,
    @visibleForTesting
    Function(FlutterMatterFlutterOnOffClusterApi? api,
            {BinaryMessenger? binaryMessenger})
        setupFlutterOnOffClusterApiFn = FlutterMatterFlutterOnOffClusterApi.setup,
  }) : _flutterMatterHostOnOffClusterApi = flutterMatterHostOnOffClusterApi ??
            FlutterMatterHostOnOffClusterApi() {
    setupFlutterOnOffClusterApiFn(this);
  }

  @override
  Future<void> off({required int deviceId, required int endpointId}) =>
      _flutterMatterHostOnOffClusterApi.off(deviceId, endpointId);

  @override
  Future<void> on({required int deviceId, required int endpointId}) =>
      _flutterMatterHostOnOffClusterApi.on(deviceId, endpointId);

  @override
  Future<void> toggle({required int deviceId, required int endpointId}) =>
      _flutterMatterHostOnOffClusterApi.toggle(deviceId, endpointId);

  @override
  Future<bool> readOnOff({required int deviceId, required int endpointId}) =>
      _flutterMatterHostOnOffClusterApi.readOnOff(deviceId, endpointId);

  @override
  Stream<bool> subscribeOnOff({
    required int deviceId,
    required int endpointId,
  }) {
    if (_onOffSubscriptions.containsKey((deviceId, endpointId))) {
      return _onOffSubscriptions[(deviceId, endpointId)]!.stream;
    }

    final subject = PublishSubject<bool>(
        onListen: () => _flutterMatterHostOnOffClusterApi.subscribeToOnOff(
            deviceId, endpointId),
        onCancel: () => _flutterMatterHostOnOffClusterApi.unsubscribeToOnOff(
            deviceId, endpointId));

    _onOffSubscriptions[(deviceId, endpointId)] = subject;
    return subject.stream;
  }

  @override
  void onOff(int deviceId, int endpointId, bool? onOff, AndroidError? error) {
    final subject = _onOffSubscriptions[(deviceId, endpointId)];

    if (error != null) {
      subject?.addError(
          PlatformException(code: error.code, message: error.message));
      return;
    }

    if (onOff == null) {
      subject?.addError(AssertionError(
          'Argument for FlutterMatterFlutterOnOffClusterApi.onOff was null, expected non-null bool.'));
      return;
    }

    subject?.add(onOff);
  }
}
