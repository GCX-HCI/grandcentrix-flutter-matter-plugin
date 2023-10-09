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

  Future<void> share() async {
    try {
      final response = await _flutterMatterPlugin.openPairingWindowWithPin(
        deviceId: 123,
        duration: const Duration(minutes: 3),
        discriminator: 123,
        setupPin: 11223344,
      );
      print('Sharing done');
      if (response.manualPairingCode != null) {
        print('Manual pairing code: ${response.manualPairingCode}');
      }
      if (response.manualPairingCode != null) {
        print(
            'QR code: https://project-chip.github.io/connectedhomeip/qrcode.html?data=${Uri.encodeComponent(response.qrCode!)}');
      }
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

  Future<void> readOnOffAttribute() async {
    try {
      final result = await _flutterMatterPlugin.onOffCluster.readOnOff(
        deviceId: 123,
        endpointId: 1,
      );
      print('Light is ${result ? 'on' : 'off'}');
    } catch (e, st) {
      print('Error: $e\n$st');
    }
  }

  Future<void> readDescriptorAttributes({int endpointId = 0}) async {
    try {
      print('Processing part [$endpointId]');
      final partsList = await _flutterMatterPlugin.descriptorCluster
          .partsList(deviceId: 123, endpointId: endpointId);

      print('parts attribute: ${partsList.join(', ')}');

      final deviceTypeList = await _flutterMatterPlugin.descriptorCluster
          .deviceTypeList(deviceId: 123, endpointId: endpointId);
      print('device attribute: ${deviceTypeList.join(', ')}');

      final serverList = await _flutterMatterPlugin.descriptorCluster
          .serverList(deviceId: 123, endpointId: endpointId);

      print(
          'server attribute: ${serverList.map((e) => '0x${e.toRadixString(16).padLeft(4, '0')}').join(', ')}');

      final clientList = await _flutterMatterPlugin.descriptorCluster
          .clientList(deviceId: 123, endpointId: endpointId);

      print(
          'client attribute: ${clientList.map((e) => '0x${e.toRadixString(16).padLeft(4, '0')}').join(', ')}');

      for (var part in partsList) {
        await readDescriptorAttributes(endpointId: part);
      }
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
                onPressed: () => share(),
                child: const Text('Share'),
              ),
              TextButton(
                onPressed: () => unpair(),
                child: const Text('Unpair device'),
              ),
              TextButton(
                onPressed: () => toggleOnOffCluster(),
                child: const Text('Toggle On/Off cluster on enpoint 1'),
              ),
              TextButton(
                onPressed: () => readOnOffAttribute(),
                child: const Text('Read On/Off attribute on enpoint 1'),
              ),
              TextButton(
                onPressed: () => readDescriptorAttributes(),
                child: const Text('Read descriptor attributes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
