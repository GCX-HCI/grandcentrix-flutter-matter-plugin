import 'package:async/async.dart';
import 'package:checks/checks.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matter_ios/src/clusters/flutter_matter_ios_onoff_cluster.dart';
import 'package:flutter_matter_ios/src/flutter_matter.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_matter_ios_onoff_cluster_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterMatterHostOnOffClusterApi>(),
])
void main() {
  late FlutterMatterIosOnOffCluster sut;

  late MockFlutterMatterHostOnOffClusterApi
      mockFlutterMatterHostOnOffClusterApi;

  setUp(() {
    mockFlutterMatterHostOnOffClusterApi =
        MockFlutterMatterHostOnOffClusterApi();

    sut = FlutterMatterIosOnOffCluster(
      flutterMatterHostOnOffClusterApi: mockFlutterMatterHostOnOffClusterApi,
      setupFlutterOnOffClusterApiFn: (api, {binaryMessenger}) {},
    );
  });

  group('ctor', () {
    test('should call the setupFlutterOnOffClusterApiFn-method', () {
      var called = false;
      FlutterMatterIosOnOffCluster(
        flutterMatterHostOnOffClusterApi: mockFlutterMatterHostOnOffClusterApi,
        setupFlutterOnOffClusterApiFn: (api, {binaryMessenger}) {
          called = true;
        },
      );

      check(called).isTrue();
    });
  });

  group('FlutterMatterOnOffClusterInterface', () {
    group('off', () {
      test('should call host api', () async {
        await check(sut.off(deviceId: 123, endpointId: 1)).completes();

        verify(mockFlutterMatterHostOnOffClusterApi.off(123, 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterHostOnOffClusterApi.off(123, 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.off(deviceId: 123, endpointId: 1)).throws();
      });
    });

    group('on', () {
      test('should call host api', () async {
        await check(sut.on(deviceId: 123, endpointId: 1)).completes();

        verify(mockFlutterMatterHostOnOffClusterApi.on(123, 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterHostOnOffClusterApi.on(123, 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.on(deviceId: 123, endpointId: 1)).throws();
      });
    });

    group('toggle', () {
      test('should call host api', () async {
        await check(sut.toggle(deviceId: 123, endpointId: 1)).completes();

        verify(mockFlutterMatterHostOnOffClusterApi.toggle(123, 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterHostOnOffClusterApi.toggle(123, 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.toggle(deviceId: 123, endpointId: 1)).throws();
      });
    });

    group('readOnOff', () {
      test('should call host api', () async {
        when(mockFlutterMatterHostOnOffClusterApi.readOnOff(123, 1))
            .thenAnswer((_) async => true);

        await check(sut.readOnOff(deviceId: 123, endpointId: 1))
            .completes(it()..isTrue());

        verify(mockFlutterMatterHostOnOffClusterApi.readOnOff(123, 1));
      });

      test('should rethrow exceptions', () async {
        when(mockFlutterMatterHostOnOffClusterApi.readOnOff(123, 1))
            .thenAnswer((_) async => throw Exception());

        await check(sut.readOnOff(deviceId: 123, endpointId: 1)).throws();
      });
    });

    group('subscribeOnOff', () {
      test(
          'should start subscribing attribute on cluster, when listen to stream',
          () {
        var subscription =
            sut.subscribeOnOff(deviceId: 123, endpointId: 1).listen((event) {});

        verify(mockFlutterMatterHostOnOffClusterApi.subscribeToOnOff(123, 1));

        subscription.cancel();
      });

      test(
          'should stop subscribing attribute on cluster, when stream subscription is cancelled',
          () {
        var subscription =
            sut.subscribeOnOff(deviceId: 123, endpointId: 1).listen((event) {});

        // var onOffQueue =
        //     StreamQueue<bool>(sut.subscribeOnOff(deviceId: 123, endpointId: 1));
        // onOffQueue.cancel();
        subscription.cancel();

        verify(mockFlutterMatterHostOnOffClusterApi.unsubscribeToOnOff(123, 1));
      });

      test('should return same stream for same deviceId and endpointId', () {
        final stream0 = sut.subscribeOnOff(deviceId: 123, endpointId: 1);
        final subscription0 = stream0.listen((event) {});

        final stream1 = sut.subscribeOnOff(deviceId: 123, endpointId: 1);
        final subscription1 = stream1.listen((event) {});

        verify(mockFlutterMatterHostOnOffClusterApi.subscribeToOnOff(123, 1))
            .called(1);

        check(stream0).equals(stream1);

        subscription0.cancel();
        subscription1.cancel();
      });

      test(
          'should unsubscribe attribute on cluster, when all streams cancelled',
          () {
        final subscription0 =
            sut.subscribeOnOff(deviceId: 123, endpointId: 1).listen((event) {});
        final subscription1 =
            sut.subscribeOnOff(deviceId: 123, endpointId: 1).listen((event) {});

        subscription0.cancel();

        verifyNever(
            mockFlutterMatterHostOnOffClusterApi.unsubscribeToOnOff(123, 1));

        subscription1.cancel();

        verify(mockFlutterMatterHostOnOffClusterApi.unsubscribeToOnOff(123, 1))
            .called(1);
      });
    });
  });

  group('FlutterMatterFlutterOnOffClusterApi', () {
    group('onOff', () {
      test(
          'should emit values to subscribeOnOff stream, when stream is listened to',
          () async {
        final streamQueue =
            StreamQueue(sut.subscribeOnOff(deviceId: 123, endpointId: 1));

        sut.onOff(123, 1, true, null);

        await check(streamQueue).emits(it()..isTrue());

        streamQueue.cancel();
      });

      test('shouldn\'t crash, when stream has no listener', () async {
        sut.onOff(123, 1, true, null);
      });

      test('shouldn\'t crash, when stream was cancelled', () async {
        final subscription =
            sut.subscribeOnOff(deviceId: 123, endpointId: 1).listen((event) {});
        subscription.cancel();

        sut.onOff(123, 1, true, null);
      });

      test(
          'should emit a PlatformException to subscribeOnOff stream, when error isn\'t null',
          () async {
        final streamQueue =
            StreamQueue(sut.subscribeOnOff(deviceId: 123, endpointId: 1));

        sut.onOff(123, 1, true, IosError(code: '-1', message: 'bad error'));

        await check(streamQueue).emitsError<PlatformException>(
          it()
            ..isA<PlatformException>()
            ..has((p0) => p0.code, 'code').equals('-1')
            ..has((p0) => p0.message, 'message').equals('bad error'),
        );

        streamQueue.cancel();
      });

      test(
          'should emit an AssertionError to subscribeOnOff stream, when status and error is null',
          () async {
        final streamQueue =
            StreamQueue(sut.subscribeOnOff(deviceId: 123, endpointId: 1));

        sut.onOff(123, 1, null, null);

        await check(streamQueue).emitsError<AssertionError>(
          it()
            ..isA<AssertionError>()
            ..has((p0) => p0.message, 'message').isNotNull(),
        );

        streamQueue.cancel();
      });
    });
  });
}
