// Mocks generated by Mockito 5.4.2 from annotations
// in flutter_matter_android/test/flutter_matter_android_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter_matter_android/src/flutter_matter.g.dart' as _i2;
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

class _FakeObject_1 extends _i1.SmartFake implements Object {
  _FakeObject_1(
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
  _i3.Future<void> command(
    int? arg_deviceId,
    int? arg_endpointId,
    _i2.Cluster? arg_cluster,
    _i2.Command? arg_command,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #command,
          [
            arg_deviceId,
            arg_endpointId,
            arg_cluster,
            arg_command,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
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
        returnValue: _FakeObject_1(
          this,
          Invocation.method(
            #encode,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeObject_1(
          this,
          Invocation.method(
            #encode,
            [],
          ),
        ),
      ) as Object);
}
