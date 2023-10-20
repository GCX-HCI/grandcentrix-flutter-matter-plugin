# flutter\_matter\_platfrom\_interface

A common platform interface for the [`flutter_matter`][1] plugin.

This interface allows platform-specific implementations of the `flutter_matter`
plugin, as well as the plugin itself, to ensure they are supporting the
same interface.

# Usage

To implement a new platform-specific implementation of `flutter_matter`, extend
[`FlutterMatterPlatform`][2] with an implementation that performs the
platform-specific behavior.

# Contributing
Contributions, issues and feature requests are welcome.
Feel free to check issues page if you want to contribute.
[Check the contributing guide](../CONTRIBUTING.md).

# Issues

Please file any issues, bugs or feature requests as an issue on our [GitHub page](TODO).

# Author
Developed by [grandcentrix](https://grandcentrix.net/). We make IoT happen.

[1]: ../flutter_matter
[2]: lib/src/flutter_matter_platform_interface.dart
