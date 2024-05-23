// Mocks generated by Mockito 5.4.2 from annotations
// in flutter_matter_ios/test/flutter_matter_ios_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter_matter_ios/src/flutter_matter.g.dart' as _i2;
import 'package:flutter_matter_platfrom_interface/src/cluster_interfaces/flutter_matter_descriptor_cluster_interface.dart'
    as _i5;
import 'package:flutter_matter_platfrom_interface/src/cluster_interfaces/flutter_matter_onoff_cluster_interface.dart'
    as _i4;
import 'package:flutter_matter_platfrom_interface/src/models/flutter_matter_descriptor_cluster_device_type_struct.dart'
    as _i6;
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

class _FakeMatterDevice_0 extends _i1.SmartFake implements _i2.MatterDevice {
  _FakeMatterDevice_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOpenPairingWindowResult_1 extends _i1.SmartFake
    implements _i2.OpenPairingWindowResult {
  _FakeOpenPairingWindowResult_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeObject_2 extends _i1.SmartFake implements Object {
  _FakeObject_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FlutterMatterHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterMatterHostApi extends _i1.Mock
    implements _i2.FlutterMatterHostApi {
  @override
  _i3.Future<String> getPlatformVersion() => (super.noSuchMethod(
        Invocation.method(
          #getPlatformVersion,
          [],
        ),
        returnValue: _i3.Future<String>.value(''),
        returnValueForMissingStub: _i3.Future<String>.value(''),
      ) as _i3.Future<String>);
  @override
  _i3.Future<void> initParams(_i2.InitParams? arg_params) =>
      (super.noSuchMethod(
        Invocation.method(
          #initParams,
          [arg_params],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<_i2.MatterDevice> commission(_i2.CommissionRequest? arg_request) =>
      (super.noSuchMethod(
        Invocation.method(
          #commission,
          [arg_request],
        ),
        returnValue: _i3.Future<_i2.MatterDevice>.value(_FakeMatterDevice_0(
          this,
          Invocation.method(
            #commission,
            [arg_request],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.MatterDevice>.value(_FakeMatterDevice_0(
          this,
          Invocation.method(
            #commission,
            [arg_request],
          ),
        )),
      ) as _i3.Future<_i2.MatterDevice>);
  @override
  _i3.Future<void> unpair(int? arg_deviceId) => (super.noSuchMethod(
        Invocation.method(
          #unpair,
          [arg_deviceId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<_i2.OpenPairingWindowResult> openPairingWindowWithPin(
    int? arg_deviceId,
    int? arg_duration,
    int? arg_discriminator,
    int? arg_setupPin,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #openPairingWindowWithPin,
          [
            arg_deviceId,
            arg_duration,
            arg_discriminator,
            arg_setupPin,
          ],
        ),
        returnValue: _i3.Future<_i2.OpenPairingWindowResult>.value(
            _FakeOpenPairingWindowResult_1(
          this,
          Invocation.method(
            #openPairingWindowWithPin,
            [
              arg_deviceId,
              arg_duration,
              arg_discriminator,
              arg_setupPin,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.OpenPairingWindowResult>.value(
                _FakeOpenPairingWindowResult_1(
          this,
          Invocation.method(
            #openPairingWindowWithPin,
            [
              arg_deviceId,
              arg_duration,
              arg_discriminator,
              arg_setupPin,
            ],
          ),
        )),
      ) as _i3.Future<_i2.OpenPairingWindowResult>);
}

/// A class which mocks [MatterDevice].
///
/// See the documentation for Mockito's code generation for more information.
class MockMatterDevice extends _i1.Mock implements _i2.MatterDevice {
  @override
  int get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  set id(int? _id) => super.noSuchMethod(
        Invocation.setter(
          #id,
          _id,
        ),
        returnValueForMissingStub: null,
      );
  @override
  Object encode() => (super.noSuchMethod(
        Invocation.method(
          #encode,
          [],
        ),
        returnValue: _FakeObject_2(
          this,
          Invocation.method(
            #encode,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeObject_2(
          this,
          Invocation.method(
            #encode,
            [],
          ),
        ),
      ) as Object);
}

/// A class which mocks [OpenPairingWindowResult].
///
/// See the documentation for Mockito's code generation for more information.
class MockOpenPairingWindowResult extends _i1.Mock
    implements _i2.OpenPairingWindowResult {
  @override
  set manualPairingCode(String? _manualPairingCode) => super.noSuchMethod(
        Invocation.setter(
          #manualPairingCode,
          _manualPairingCode,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set qrCode(String? _qrCode) => super.noSuchMethod(
        Invocation.setter(
          #qrCode,
          _qrCode,
        ),
        returnValueForMissingStub: null,
      );
  @override
  Object encode() => (super.noSuchMethod(
        Invocation.method(
          #encode,
          [],
        ),
        returnValue: _FakeObject_2(
          this,
          Invocation.method(
            #encode,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeObject_2(
          this,
          Invocation.method(
            #encode,
            [],
          ),
        ),
      ) as Object);
}

/// A class which mocks [FlutterMatterOnOffClusterInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterMatterOnOffClusterInterface extends _i1.Mock
    implements _i4.FlutterMatterOnOffClusterInterface {
  @override
  _i3.Future<void> off({
    required int? deviceId,
    required int? endpointId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #off,
          [],
          {
            #deviceId: deviceId,
            #endpointId: endpointId,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> on({
    required int? deviceId,
    required int? endpointId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #on,
          [],
          {
            #deviceId: deviceId,
            #endpointId: endpointId,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> toggle({
    required int? deviceId,
    required int? endpointId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #toggle,
          [],
          {
            #deviceId: deviceId,
            #endpointId: endpointId,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<bool> readOnOff({
    required int? deviceId,
    required int? endpointId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readOnOff,
          [],
          {
            #deviceId: deviceId,
            #endpointId: endpointId,
          },
        ),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Stream<bool> subscribeOnOff({
    required int? deviceId,
    required int? endpointId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #subscribeOnOff,
          [],
          {
            #deviceId: deviceId,
            #endpointId: endpointId,
          },
        ),
        returnValue: _i3.Stream<bool>.empty(),
        returnValueForMissingStub: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);
}

/// A class which mocks [FlutterMatterDescriptorClusterInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterMatterDescriptorClusterInterface extends _i1.Mock
    implements _i5.FlutterMatterDescriptorClusterInterface {
  @override
  _i3.Future<List<_i6.FlutterMatterDescriptorClusterDeviceTypeStruct?>>
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
                        _i6
                        .FlutterMatterDescriptorClusterDeviceTypeStruct?>>.value(
                <_i6.FlutterMatterDescriptorClusterDeviceTypeStruct?>[]),
            returnValueForMissingStub: _i3.Future<
                    List<
                        _i6
                        .FlutterMatterDescriptorClusterDeviceTypeStruct?>>.value(
                <_i6.FlutterMatterDescriptorClusterDeviceTypeStruct?>[]),
          ) as _i3.Future<
              List<_i6.FlutterMatterDescriptorClusterDeviceTypeStruct?>>);
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
