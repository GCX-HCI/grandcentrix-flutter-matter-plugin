import 'package:flutter_matter_platfrom_interface/src/flutter_matter_attribute.dart';
import 'package:flutter_matter_platfrom_interface/src/flutter_matter_cluster.dart';
import 'package:flutter_matter_platfrom_interface/src/flutter_matter_command.dart';
import 'package:flutter_matter_platfrom_interface/src/flutter_matter_device.dart';
import 'package:flutter_matter_platfrom_interface/src/flutter_matter_open_pairing_window_result.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:flutter_matter_platfrom_interface/src/flutter_matter_method_channel.dart';

/// The interface that implementations of flutter_matter must implement.
///
/// Platform implementations should extend this class rather than implement it
/// as `FlutterMatter` does not consider newly added methods to be breaking
/// changes. Extending this class (using `extends`) ensures that the subclass
/// will get the default implementation, while platform implementations that
/// `implements` this interface will be broken by newly added
/// [FlutterMatterPlatform] methods.
abstract class FlutterMatterPlatform extends PlatformInterface {
  /// Constructs a FlutterMatterPlatform.
  FlutterMatterPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMatterPlatform _instance = MethodChannelFlutterMatter();

  /// The default instance of [FlutterMatterPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMatter].
  static FlutterMatterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMatterPlatform] when
  /// they register themselves.
  static set instance(FlutterMatterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Sanity check test method
  Future<String?> getPlatformVersion() async {
    return Future.error(
      UnimplementedError('platformVersion() has not been implemented.'),
    );
  }

  /// Commission a matter device with the provided `deviceId`
  Future<FlutterMatterDevice> commission({required int deviceId}) async {
    return Future.error(
      UnimplementedError('commission() has not been implemented.'),
    );
  }

  /// Removes the app's fabric from the device
  Future<void> unpair({required int deviceId}) async {
    return Future.error(
      UnimplementedError('unpair() has not been implemented.'),
    );
  }

  /// Open a pairing window on the device
  Future<FlutterMatterOpenPairingWindowResult> openPairingWindowWithPin({
    required int deviceId,
    required Duration duration,
    required int discriminator,
    required int setupPin,
  }) {
    return Future.error(
      UnimplementedError('openPairingWindowWithPin has not been implemented.'),
    );
  }

  /// Sends the `command` to a matter device with the provided `deviceId` and `endpointId` on the `cluster`
  Future<void> command({
    required int deviceId,
    required int endpointId,
    required FlutterMatterCluster cluster,
    required FlutterMatterCommand command,
  }) async {
    return Future.error(
      UnimplementedError('command() has not been implemented.'),
    );
  }

  /// Reads the `attribute` from a matter device with the provided `deviceId` and `endpointId` on the `cluster`
  Future<Object> attribute({
    required int deviceId,
    required int endpointId,
    required FlutterMatterCluster cluster,
    required FlutterMatterAttribute attribute,
  }) async {
    return Future.error(
      UnimplementedError('attribute() has not been implemented.'),
    );
  }
}
