import 'package:flutter_matter/src/utils/specifyplatformexception.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// This cluster provides an interface to temperature measurement functionality, including configura­ tion and provision of notifications of temperature measurements
final class TemperatureCluster with SpecifyPlatfromException {
  final FlutterMatterPlatformInterface _instance;

  /// Should not be used! Access via [FlutterMatter.temperatureCluster]
  TemperatureCluster(FlutterMatterPlatformInterface instance)
      : _instance = instance;

  /// Attributes

  /// Read attribute MinMeasuredValue
  ///
  /// The MinMeasuredValue attribute indicates the minimum value of MeasuredValue that is capable of being measured.
  /// The null value indicates that the value is not available.
  Future<int?> readMaxMeasuredValue(
          {required int deviceId, required int endpointId}) =>
      catchSpecifyRethrow(() => _instance.temperatureCluster
          .readMaxMeasuredValue(deviceId: deviceId, endpointId: endpointId));

  /// Read attribute MeasuredValue
  ///
  /// Represents the temperature in degrees Celsius as follows: MeasuredValue = 100 x temperature [°C]
  /// Where -273.15°C ≤ temperature ≤ 327.67°C, with a resolution of 0.01°C.
  /// The null value indicates that the temperature is unknown.
  Future<int?> readMeasuredValue(
          {required int deviceId, required int endpointId}) =>
      catchSpecifyRethrow(() => _instance.temperatureCluster
          .readMeasuredValue(deviceId: deviceId, endpointId: endpointId));

  /// Read attribute MaxMeasuredValue
  ///
  /// The MaxMeasuredValue attribute indicates the maximum value of MeasuredValue that is capable of being measured.
  /// The null value indicates that the value is not available.
  Future<int?> readMinMeasuredValue(
          {required int deviceId, required int endpointId}) =>
      catchSpecifyRethrow(() => _instance.temperatureCluster
          .readMinMeasuredValue(deviceId: deviceId, endpointId: endpointId));

  /// Read attribute Tolerance
  ///
  /// The Tolerance attribute SHALL indicate the magnitude of the possible error that is associated with MeasuredValue attribute, using the same units and resolution. The true value SHALL be in the range (MeasuredValue – Tolerance) to (MeasuredValue + Tolerance).
  /// The null value indicates that the value is not available.
  Future<int?> readTolerance(
          {required int deviceId, required int endpointId}) =>
      catchSpecifyRethrow(() => _instance.temperatureCluster
          .readTolerance(deviceId: deviceId, endpointId: endpointId));
}
