// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matter/flutter_matter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

late final FlutterMatter _flutterMatterPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // IMPORTANT: Change the parameter `appGroup` to your App Group defined in the iOS App Group capabilities. See the README for setup!
  _flutterMatterPlugin = await FlutterMatter.createInstance(
    appGroup: 'group.example.flutterMatterExample',
    ecoSystemName: 'testEcoSystemName',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String _nextDeviceIdKey = 'NextDeviceIdKey';
  static const String _connectedDevicesIdKey = 'ConnectedDevicesIdKey';

  int _nextDeviceId = -1;
  String _platformVersion = 'Unknown';
  List<int> _devices = [];

  late final SharedPreferences _prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Matter Example App'),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              // Commisson a device
              try {
                final device = await _flutterMatterPlugin.commission(
                    deviceId: _nextDeviceId);
                // Device successfully comissioned!
                setState(() {
                  _devices.add(device.id);
                });

                // Save next available device id to shared prefs
                _nextDeviceId++;
                await _prefs.setInt(_nextDeviceIdKey, _nextDeviceId);

                // Save connected devices to shared prefs
                await _prefs.setStringList(_connectedDevicesIdKey,
                    _devices.map((e) => e.toString()).toList());

                // Read descriptor attributes
                await readDescriptorAttributes(device.id);
              } catch (e, st) {
                // Commissioing wasn't successful!

                print('Error: $e\n$st');
                if (!context.mounted) return;
                await showAdaptiveDialog(
                  context: context,
                  builder: (ctx) => AlertDialog.adaptive(
                    icon: const Icon(Icons.error),
                    title: const Text('Error!'),
                    content: Text(e.toString()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Ok'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: _devices.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No devices yet!',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Text(
                                'Start by adding your first matter device!',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: _devices.length,
                            itemBuilder: (ctx, i) => LightDeviceWidget(
                              deviceId: _devices[i],
                              unpaired: (id) {
                                _devices.remove(id);
                                setState(() {});
                              },
                            ),
                            padding: const EdgeInsetsDirectional.all(16.0),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Running on: $_platformVersion'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      // ignore: invalid_use_of_visible_for_testing_member
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

  Future<void> initSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();

    // Get next available device id from shared prefs
    _nextDeviceId = _prefs.getInt(_nextDeviceIdKey) ?? 1;
    // Get saved connected devices from shared prefs
    _devices = _prefs
            .getStringList(_connectedDevicesIdKey)
            ?.map((e) => int.parse(e))
            .toList() ??
        [];
  }

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
    initPlatformState();
  }

  Future<void> readDescriptorAttributes(int deviceId,
      {int endpointId = 0}) async {
    try {
      print('Processing part [$endpointId]');
      final partsList = await _flutterMatterPlugin.descriptorCluster
          .partsList(deviceId: deviceId, endpointId: endpointId);

      print('parts attribute: ${partsList.join(', ')}');

      final deviceTypeList = await _flutterMatterPlugin.descriptorCluster
          .deviceTypeList(deviceId: deviceId, endpointId: endpointId);
      print('device attribute: ${deviceTypeList.join(', ')}');

      final serverList = await _flutterMatterPlugin.descriptorCluster
          .serverList(deviceId: deviceId, endpointId: endpointId);

      print(
          'server attribute: ${serverList.map((e) => '0x${e.toRadixString(16).padLeft(4, '0')}').join(', ')}');

      final clientList = await _flutterMatterPlugin.descriptorCluster
          .clientList(deviceId: deviceId, endpointId: endpointId);

      print(
          'client attribute: ${clientList.map((e) => '0x${e.toRadixString(16).padLeft(4, '0')}').join(', ')}');

      for (var part in partsList) {
        await readDescriptorAttributes(deviceId, endpointId: part);
      }
    } catch (e, st) {
      print('Error: $e\n$st');
    }
  }
}

class LightDeviceWidget extends StatefulWidget {
  final int _deviceId;

  final Function(int) _unpaired;

  const LightDeviceWidget({
    super.key,
    required deviceId,
    required Function(int) unpaired,
  })  : _deviceId = deviceId,
        _unpaired = unpaired;

  @override
  State<LightDeviceWidget> createState() => _LightDeviceWidgetState();
}

class _LightDeviceWidgetState extends State<LightDeviceWidget> {
  bool _isOn = false;

  StreamSubscription<bool>? _streamSubscription;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.lightbulb,
        color: _isOn ? Colors.yellow : Colors.grey,
      ),
      title: Text(
        'DeviceId: ${widget._deviceId}',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      trailing: Switch.adaptive(
        value: _isOn,
        onChanged: (value) async {
          // Call command ion or off according to value
          try {
            if (value) {
              await _flutterMatterPlugin.onOffCluster.on(
                deviceId: widget._deviceId,
                endpointId: 1,
              );
            } else {
              await _flutterMatterPlugin.onOffCluster.off(
                deviceId: widget._deviceId,
                endpointId: 1,
              );
            }

            setState(() {
              _isOn = value;
            });
          } catch (e, st) {
            print('Error: $e\n$st');

            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error! ${e.toString()}'),
            ));
          }
        },
      ),
      onTap: () async => showAdaptiveDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Device ${widget._deviceId}'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Unpair'),
              onPressed: () async {
                // Unpair a matter device
                try {
                  await _flutterMatterPlugin.unpair(deviceId: widget._deviceId);
                  widget._unpaired(widget._deviceId);
                } catch (e, st) {
                  print('Error: $e\n$st');

                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error! ${e.toString()}'),
                  ));
                }

                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Share'),
              onPressed: () async {
                // Share a device and launch website to show qr code data
                try {
                  final response =
                      await _flutterMatterPlugin.openPairingWindowWithPin(
                    deviceId: widget._deviceId,
                    duration: const Duration(minutes: 3),
                    discriminator: 123,
                    setupPin: 11223344,
                  );
                  final Uri url = Uri.parse(
                      'https://project-chip.github.io/connectedhomeip/qrcode.html?data=${Uri.encodeComponent(response.qrCode!)}');

                  await launchUrl(url);
                } catch (e, st) {
                  print('Error: $e\n$st');

                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error! ${e.toString()}'),
                  ));
                }

                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    // Don't forget to cancel stream subscriptions to prevent memory leaks!
    _streamSubscription?.cancel();
  }

  @override
  void initState() {
    super.initState();
    readOnOff();
    subscribeOnOff();
  }

  Future<void> readOnOff() async {
    try {
      // Read the initial on/off attribute value
      _isOn = await _flutterMatterPlugin.onOffCluster.readOnOff(
        deviceId: widget._deviceId,
        endpointId: 1,
      );
      print('Light is ${_isOn ? 'on' : 'off'}');
    } catch (e, st) {
      print('Error: $e\n$st');

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error! ${e.toString()}'),
      ));
    }
  }

  Future<void> subscribeOnOff() async {
    try {
      // Subscribe the on/off attribute value
      _streamSubscription = _flutterMatterPlugin.onOffCluster
          .subscribeOnOff(
        deviceId: widget._deviceId,
        endpointId: 1,
      )
          .listen((event) {
        setState(() {
          _isOn = event;
        });
        print('Light is ${_isOn ? 'on' : 'off'}');
      });
    } catch (e, st) {
      print('Error: $e\n$st');

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error! ${e.toString()}'),
      ));
    }
  }
}
