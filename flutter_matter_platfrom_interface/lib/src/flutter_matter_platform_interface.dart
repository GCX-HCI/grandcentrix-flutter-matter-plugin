import 'package:flutter/foundation.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';
import 'package:flutter_matter_platfrom_interface/src/cluster_interfaces/flutter_matter_onoff_cluster_interface.dart';
import 'package:flutter_matter_platfrom_interface/src/models/flutter_matter_device.dart';
import 'package:flutter_matter_platfrom_interface/src/models/flutter_matter_open_pairing_window_result.dart';
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
    if (!_skipVerifyForTesting) {
      PlatformInterface.verify(instance, _token);
    }
    _instance = instance;
  }

  static bool _skipVerifyForTesting = false;
  @visibleForTesting
  static set skipVerifyForTesting(bool skip) {
    _skipVerifyForTesting = skip;
  }

  /// Sanity check test method
  Future<String?> getPlatformVersion();

  /// Commission a matter device with the provided `deviceId`
  Future<FlutterMatterDevice> commission({required int deviceId});

  /// Removes the app's fabric from the device
  Future<void> unpair({required int deviceId});

  /// Open a pairing window on the device
  Future<FlutterMatterOpenPairingWindowResult> openPairingWindowWithPin({
    required int deviceId,
    required Duration duration,
    required int discriminator,
    required int setupPin,
  });

  FlutterMatterOnOffClusterInterface get onOffCluster;

  FlutterMatterDescriptorClusterInterface get descriptorCluster;
}
