// Mocks generated by Mockito 5.4.2 from annotations
// in flutter_matter/test/clusters/on_off_cluster_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter_matter_platfrom_interface/src/cluster_interfaces/flutter_matter_onoff_cluster_interface.dart'
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

/// A class which mocks [FlutterMatterOnOffClusterInterface].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterMatterOnOffClusterInterface extends _i1.Mock
    implements _i2.FlutterMatterOnOffClusterInterface {
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
