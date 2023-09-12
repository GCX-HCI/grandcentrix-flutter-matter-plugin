# flutter\_matter

Commission, control and share matter devices.

## Platform Support

This plugin needs at least Android 8.1 (API level 27) and iOS 16.1+ 

| Feature                | Android | iOS |
| :--------------------: | :-----: | :-: |
| Commissioning          | ✅      | ⛔  |
| Control On/Off cluster | ⛔      | ⛔  |
| Share                  | ⛔      | ⛔  |

## Quickstart 

1. Add a `dependency` on `flutter_matter: ^0.0.1`.
2. See [Setup for Android](#setup-for-android) and [Setup for iOS](#setup-for-ios)
3. Add an import for `package:flutter_matter/flutter_matter.dart`.
4. Use flutter_matter in your code:
```dart
import 'package:flutter_matter/flutter_matter.dart';

final flutterMatterPlugin = FlutterMatter();

// Commission a device
try {
    final device = await flutterMatterPlugin.commission(deviceId: 123);
    print('Comissioned $device');
} catch (e) {
    print('Error: $e');
}
```

### Setup for Android

Add permissions to your `AndroidManifest.xml` and don't forget to include the tools namespace in the `manifest`-Tag `xmlns:tools="http://schemas.android.com/tools"`:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <!-- BluetoothLE (BLE) -->
    <!-- https://developer.android.com/reference/android/bluetooth/le/BluetoothLeScanner#startScan(java.util.List%3Candroid.bluetooth.le.ScanFilter%3E,%20android.bluetooth.le.ScanSettings,%20android.bluetooth.le.ScanCallback)  -->
    <!-- Android Q (28) or later must have ACCESS_FINE_LOCATION -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"
        tools:ignore="CoarseFineLocation" />
    <!-- Needed for <= Build.VERSION_CODES#R (30) (only needed in Manifest) -->
    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
    <!-- Needed for >= Build.VERSION_CODES#S (31) (must be requested) -->
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
    <uses-feature
        android:name="android.hardware.bluetooth_le"
        android:required="true" />

    <!-- Wi-Fi Scan -->
    <uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />

    <!-- TODO: clarify what specifically requires the permission -->
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-feature android:name="android.hardware.camera.any" android:required="false" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.CHANGE_WIFI_MULTICAST_STATE" />
    <uses-permission android:name="android.permission.NFC" />
    [...]
</manifest>
```

Add the commissioning service to your `AndroidManisfest.xml`:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    [...]
    <application
            [...] >
        [...]
        <service
            android:name="net.grandcentrix.flutter_matter.commissioning.AppCommissioningService"
            android:exported="true" />
        [...]
    </application>
</manifest>
```

To enable linking the app add the following `intent-filter` to your `AndroidManifest.xml`:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    <application
            [...] >
        <activity
            [...] >
            [...]
            <intent-filter>
                <action android:name="com.google.android.gms.home.matter.ACTION_COMMISSION_DEVICE" />
                <category android:name="android.intent.category.DEFAULT" />
            </intent-filter>
        [...]
        </activity>
    </application>
</manifest>
```

### Setup for iOS
*TODO*
