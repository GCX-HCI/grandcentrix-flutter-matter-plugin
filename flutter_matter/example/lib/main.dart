import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_matter/flutter_matter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterMatterPlugin = FlutterMatter();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterMatterPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> commissonMatterDevice() async {
    try {
      final device = await _flutterMatterPlugin.commission(deviceId: 123);
      print('Comissioned $device');
    } catch (e, st) {
      print('Error: $e\n$st');
    }
  }

  Future<void> unpair() async {
    try {
      await _flutterMatterPlugin.unpair(deviceId: 123);
      print('Unpairing done');
    } catch (e, st) {
      print('Error: $e\n$st');
    }
  }

  Future<void> toggleOnOffCluster() async {
    try {
      await _flutterMatterPlugin.onOffCluster.toggle(
        deviceId: 123,
        endpointId: 1,
      );
      print('On/Off toggled!');
    } catch (e, st) {
      print('Error: $e\n$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                onPressed: () => commissonMatterDevice(),
                child: const Text('Start commissoning'),
              ),
              TextButton(
                onPressed: () => unpair(),
                child: const Text('Unpair device'),
              ),
              TextButton(
                onPressed: () => toggleOnOffCluster(),
                child: const Text('Toggle On/Off cluster on enpoint 1'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
