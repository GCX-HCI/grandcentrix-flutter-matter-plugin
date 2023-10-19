/// Flutter Matter Exception base class
///
/// See also:
/// * [GeneralException]
/// * [UnsupportedPlatformException]
/// * [UserCancelledException]
/// * [TimeoutException]
abstract class FlutterMatterException implements Exception {
  /// A message describing the error.
  final String? message;

  /// Create a new `FlutterMatterException` with the description [message]
  FlutterMatterException(this.message);
}

/// General error which is not further specified, see the [message] for more information
class GeneralException extends FlutterMatterException {
  /// Create a new `GeneralException` with the description [message]
  GeneralException(super.message);
}

/// The platfrom you're running on is currently not supported for this command
class UnsupportedPlatformException extends FlutterMatterException {
  /// Create a new `UnsupportedPlatformException` with the description [message]
  UnsupportedPlatformException(super.message);
}

/// User cancelled the request
class UserCancelledException extends FlutterMatterException {
  /// Create a new `UserCancelledException` with the description [message]
  UserCancelledException(super.message);
}

/// Request timedout
class TimeoutException extends FlutterMatterException {
  /// Create a new `TimeoutException` with the description [message]
  TimeoutException(super.message);
}
