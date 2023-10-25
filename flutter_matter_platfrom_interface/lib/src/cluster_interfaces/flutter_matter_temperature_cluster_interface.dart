/// The interface that implementations of flutter_matter must implement.
abstract interface class FlutterMatterTemperatureClusterInterface {
  /// Read attribute MeasuredValue
  ///
  /// Represents the temperature in degrees Celsius as follows: MeasuredValue = 100 x temperature [°C]
  /// Where -273.15°C ≤ temperature ≤ 327.67°C, with a resolution of 0.01°C.
  /// The null value indicates that the temperature is unknown.
  Future<int?> readMeasuredValue({
    required int deviceId,
    required int endpointId,
  });

  /// Read attribute MinMeasuredValue
  ///
  /// The MinMeasuredValue attribute indicates the minimum value of MeasuredValue that is capable of being measured.
  /// The null value indicates that the value is not available.
  Future<int?> readMinMeasuredValue({
    required int deviceId,
    required int endpointId,
  });

  /// Read attribute MaxMeasuredValue
  ///
  /// The MaxMeasuredValue attribute indicates the maximum value of MeasuredValue that is capable of being measured.
  /// The null value indicates that the value is not available.
  Future<int?> readMaxMeasuredValue({
    required int deviceId,
    required int endpointId,
  });

  /// Read attribute Tolerance
  Future<int?> readTolerance({
    required int deviceId,
    required int endpointId,
  });
}
