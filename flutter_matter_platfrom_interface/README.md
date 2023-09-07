# flutter\_matter\_platfrom\_interface

A common platform interface for the [`flutter_matter`][1] plugin.

This interface allows platform-specific implementations of the `flutter_matter`
plugin, as well as the plugin itself, to ensure they are supporting the
same interface.

# Usage

To implement a new platform-specific implementation of `flutter_matter`, extend
[`FlutterMatterPlatform`][2] with an implementation that performs the
platform-specific behavior, and when you register your plugin, set the default
`FlutterMatterPlatform` by calling
`FlutterMatterPlatform.instance = MyPlatformFlutterMatter()`.

[1]: ../flutter_matter
[2]: lib/flutter_matter_platform_interface.dart
