import 'dart:io';

import 'package:flutter_matter/src/clusters/descriptor_cluster.dart';
import 'package:flutter_matter/src/clusters/on_off_cluster.dart';
import 'package:flutter_matter/src/clusters/temperature_cluster.dart';
import 'package:flutter_matter_android/flutter_matter_android.dart';
import 'package:flutter_matter_ios/flutter_matter_ios.dart';
import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart';

/// Factory to create public facing clusters and functions
class ClusterFactory {
  // FlutterMatterPlatformInterface

  /// Create an instance of [FlutterMatterPlatformInterface], depending on the current operating system
  ///
  /// Throws an [UnimplementedError], when the current operating system is not supported
  Future<FlutterMatterPlatformInterface> createFlutterMatterPlatformInterface(
          {required String appGroup}) async =>
      switch (Platform.operatingSystem) {
        'ios' => await FlutterMatterIos.createInstance(appGroup: appGroup),
        'android' => FlutterMatterAndroid(),
        _ => throw UnimplementedError(
            'FlutterMatter currently doesn\'t support your platform!'),
      };

  /// Create an instance of [DescriptorCluster], depending on the current operating system
  ///
  /// Throws an [UnimplementedError], when the current operating system is not supported
  DescriptorCluster createDescriptorCluster() =>
      switch (Platform.operatingSystem) {
        'ios' => DescriptorCluster(FlutterMatterIosDescriptorCluster()),
        'android' => DescriptorCluster(FlutterMatterAndroidDescriptorCluster()),
        _ => throw UnimplementedError(
            'FlutterMatter currently doesn\'t support your platform!'),
      };

  /// Create an instance of [OnOffCluster], depending on the current operating system
  ///
  /// Throws an [UnimplementedError], when the current operating system is not supported
  OnOffCluster createOnOffCluster() => switch (Platform.operatingSystem) {
        'ios' => OnOffCluster(FlutterMatterIosOnOffCluster()),
        'android' => OnOffCluster(FlutterMatterAndroidOnOffCluster()),
        _ => throw UnimplementedError(
            'FlutterMatter currently doesn\'t support your platform!'),
      };

  /// Create an instance of [TemperatureCluster], depending on the current operating system
  ///
  /// Throws an [UnimplementedError], when the current operating system is not supported
  TemperatureCluster createTemperatureCluster() =>
      switch (Platform.operatingSystem) {
        'ios' => TemperatureCluster(FlutterMatterIosTemperatureCluster()),
        'android' =>
          TemperatureCluster(FlutterMatterAndroidTemperatureCluster()),
        _ => throw UnimplementedError(
            'FlutterMatter currently doesn\'t support your platform!'),
      };
}
