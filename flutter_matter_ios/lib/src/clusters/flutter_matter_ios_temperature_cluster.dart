import 'package:flutter/foundation.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// This cluster provides an interface to temperature measurement functionality, including configura­ tion and provision of notifications of temperature measurements.
final class FlutterMatterIosTemperatureCluster
    implements FlutterMatterTemperatureClusterInterface {
  final FlutterMatterHostTemperatureClusterApi
      _flutterMatterHostTemperatureClusterApi;

  /// Creates a new Temperature cluster implementation instance.
  FlutterMatterIosTemperatureCluster({
    @visibleForTesting
    FlutterMatterHostTemperatureClusterApi?
        flutterMatterHostTemperatureClusterApi,
  }) : _flutterMatterHostTemperatureClusterApi =
            flutterMatterHostTemperatureClusterApi ??
                FlutterMatterHostTemperatureClusterApi();

  @override
  Future<int?> readMaxMeasuredValue(
          {required int deviceId, required int endpointId}) =>
      _flutterMatterHostTemperatureClusterApi.readMaxMeasuredValue(
          deviceId, endpointId);

  @override
  Future<int?> readMeasuredValue(
          {required int deviceId, required int endpointId}) =>
      _flutterMatterHostTemperatureClusterApi.readMeasuredValue(
          deviceId, endpointId);

  @override
  Future<int?> readMinMeasuredValue(
          {required int deviceId, required int endpointId}) =>
      _flutterMatterHostTemperatureClusterApi.readMinMeasuredValue(
          deviceId, endpointId);

  @override
  Future<int?> readTolerance(
          {required int deviceId, required int endpointId}) =>
      _flutterMatterHostTemperatureClusterApi.readTolerance(
          deviceId, endpointId);
}
