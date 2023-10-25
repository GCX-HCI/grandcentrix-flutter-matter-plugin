// Mocks generated by Mockito 5.4.2 from annotations
// in flutter_matter/test/clusters/descriptor_cluster_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter_matter_platfrom_interface/flutter_matter_platfrom_interface.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFlutterMatterOnOffClusterInterface_0 extends _i1.SmartFake
    implements _i2.FlutterMatterOnOffClusterInterface {
  _FakeFlutterMatterOnOffClusterInterface_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFlutterMatterDescriptorClusterInterface_1 extends _i1.SmartFake
    implements _i2.FlutterMatterDescriptorClusterInterface {
  _FakeFlutterMatterDescriptorClusterInterface_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFlutterMatterTemperatureClusterInterface_2 extends _i1.SmartFake
    implements _i2.FlutterMatterTemperatureClusterInterface {
  _FakeFlutterMatterTemperatureClusterInterface_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFlutterMatterDevice_3 extends _i1.SmartFake
    implements _i2.FlutterMatterDevice {
  _FakeFlutterMatterDevice_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFlutterMatterOpenPairingWindowResult_4 extends _i1.SmartFake
    implements _i2.FlutterMatterOpenPairingWindowResult {
  _FakeFlutterMatterOpenPairingWindowResult_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FlutterMatterPlatformInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterMatterPlatformInterface extends _i1.Mock
    implements _i2.FlutterMatterPlatformInterface {
  @override
  _i2.FlutterMatterOnOffClusterInterface get onOffCluster =>
      (super.noSuchMethod(
        Invocation.getter(#onOffCluster),
        returnValue: _FakeFlutterMatterOnOffClusterInterface_0(
          this,
          Invocation.getter(#onOffCluster),
        ),
        returnValueForMissingStub: _FakeFlutterMatterOnOffClusterInterface_0(
          this,
          Invocation.getter(#onOffCluster),
        ),
      ) as _i2.FlutterMatterOnOffClusterInterface);
  @override
  _i2.FlutterMatterDescriptorClusterInterface get descriptorCluster =>
      (super.noSuchMethod(
        Invocation.getter(#descriptorCluster),
        returnValue: _FakeFlutterMatterDescriptorClusterInterface_1(
          this,
          Invocation.getter(#descriptorCluster),
        ),
        returnValueForMissingStub:
            _FakeFlutterMatterDescriptorClusterInterface_1(
          this,
          Invocation.getter(#descriptorCluster),
        ),
      ) as _i2.FlutterMatterDescriptorClusterInterface);
  @override
  _i2.FlutterMatterTemperatureClusterInterface get temperatureCluster =>
      (super.noSuchMethod(
        Invocation.getter(#temperatureCluster),
        returnValue: _FakeFlutterMatterTemperatureClusterInterface_2(
          this,
          Invocation.getter(#temperatureCluster),
        ),
        returnValueForMissingStub:
            _FakeFlutterMatterTemperatureClusterInterface_2(
          this,
          Invocation.getter(#temperatureCluster),
        ),
      ) as _i2.FlutterMatterTemperatureClusterInterface);
  @override
  _i3.Future<String?> getPlatformVersion() => (super.noSuchMethod(
        Invocation.method(
          #getPlatformVersion,
          [],
        ),
        returnValue: _i3.Future<String?>.value(),
        returnValueForMissingStub: _i3.Future<String?>.value(),
      ) as _i3.Future<String?>);
  @override
  _i3.Future<_i2.FlutterMatterDevice> commission({required int? deviceId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #commission,
          [],
          {#deviceId: deviceId},
        ),
        returnValue: _i3.Future<_i2.FlutterMatterDevice>.value(
            _FakeFlutterMatterDevice_3(
          this,
          Invocation.method(
            #commission,
            [],
            {#deviceId: deviceId},
          ),
        )),
        returnValueForMissingStub: _i3.Future<_i2.FlutterMatterDevice>.value(
            _FakeFlutterMatterDevice_3(
          this,
          Invocation.method(
            #commission,
            [],
            {#deviceId: deviceId},
          ),
        )),
      ) as _i3.Future<_i2.FlutterMatterDevice>);
  @override
  _i3.Future<void> unpair({required int? deviceId}) => (super.noSuchMethod(
        Invocation.method(
          #unpair,
          [],
          {#deviceId: deviceId},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<_i2.FlutterMatterOpenPairingWindowResult>
      openPairingWindowWithPin({
    required int? deviceId,
    required Duration? duration,
    required int? discriminator,
    required int? setupPin,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #openPairingWindowWithPin,
              [],
              {
                #deviceId: deviceId,
                #duration: duration,
                #discriminator: discriminator,
                #setupPin: setupPin,
              },
            ),
            returnValue:
                _i3.Future<_i2.FlutterMatterOpenPairingWindowResult>.value(
                    _FakeFlutterMatterOpenPairingWindowResult_4(
              this,
              Invocation.method(
                #openPairingWindowWithPin,
                [],
                {
                  #deviceId: deviceId,
                  #duration: duration,
                  #discriminator: discriminator,
                  #setupPin: setupPin,
                },
              ),
            )),
            returnValueForMissingStub:
                _i3.Future<_i2.FlutterMatterOpenPairingWindowResult>.value(
                    _FakeFlutterMatterOpenPairingWindowResult_4(
              this,
              Invocation.method(
                #openPairingWindowWithPin,
                [],
                {
                  #deviceId: deviceId,
                  #duration: duration,
                  #discriminator: discriminator,
                  #setupPin: setupPin,
                },
              ),
            )),
          ) as _i3.Future<_i2.FlutterMatterOpenPairingWindowResult>);
}

/// A class which mocks [FlutterMatterDescriptorClusterInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterMatterDescriptorClusterInterface extends _i1.Mock
    implements _i2.FlutterMatterDescriptorClusterInterface {
  @override
  _i3.Future<List<_i2.FlutterMatterDescriptorClusterDeviceTypeStruct?>>
      readDeviceTypeList({
    required int? deviceId,
    required int? endpointId,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #readDeviceTypeList,
              [],
              {
                #deviceId: deviceId,
                #endpointId: endpointId,
              },
            ),
            returnValue: _i3.Future<
                    List<
                        _i2
                        .FlutterMatterDescriptorClusterDeviceTypeStruct?>>.value(
                <_i2.FlutterMatterDescriptorClusterDeviceTypeStruct?>[]),
            returnValueForMissingStub: _i3.Future<
                    List<
                        _i2
                        .FlutterMatterDescriptorClusterDeviceTypeStruct?>>.value(
                <_i2.FlutterMatterDescriptorClusterDeviceTypeStruct?>[]),
          ) as _i3.Future<
              List<_i2.FlutterMatterDescriptorClusterDeviceTypeStruct?>>);
  @override
  _i3.Future<List<int?>> readServerList({
    required int? deviceId,
    required int? endpointId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readServerList,
          [],
          {
            #deviceId: deviceId,
            #endpointId: endpointId,
          },
        ),
        returnValue: _i3.Future<List<int?>>.value(<int?>[]),
        returnValueForMissingStub: _i3.Future<List<int?>>.value(<int?>[]),
      ) as _i3.Future<List<int?>>);
  @override
  _i3.Future<List<int?>> readClientList({
    required int? deviceId,
    required int? endpointId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readClientList,
          [],
          {
            #deviceId: deviceId,
            #endpointId: endpointId,
          },
        ),
        returnValue: _i3.Future<List<int?>>.value(<int?>[]),
        returnValueForMissingStub: _i3.Future<List<int?>>.value(<int?>[]),
      ) as _i3.Future<List<int?>>);
  @override
  _i3.Future<List<int?>> readPartsList({
    required int? deviceId,
    required int? endpointId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readPartsList,
          [],
          {
            #deviceId: deviceId,
            #endpointId: endpointId,
          },
        ),
        returnValue: _i3.Future<List<int?>>.value(<int?>[]),
        returnValueForMissingStub: _i3.Future<List<int?>>.value(<int?>[]),
      ) as _i3.Future<List<int?>>);
}

/// A class which mocks [FlutterMatterDescriptorClusterDeviceTypeStruct].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterMatterDescriptorClusterDeviceTypeStruct extends _i1.Mock
    implements _i2.FlutterMatterDescriptorClusterDeviceTypeStruct {
  @override
  int get deviceType => (super.noSuchMethod(
        Invocation.getter(#deviceType),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  int get revision => (super.noSuchMethod(
        Invocation.getter(#revision),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
}
