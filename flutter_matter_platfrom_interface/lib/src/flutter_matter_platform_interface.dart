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

  Future<String?> getPlatformVersion() async {
    return Future.error(
      UnimplementedError('platformVersion() has not been implemented.'),
    );
  }
}
