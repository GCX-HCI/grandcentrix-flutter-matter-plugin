import 'package:checks/checks.dart';
import 'package:flutter/services.dart';
import 'package:flutter_matter/src/exceptions/flutter_matter_exceptions.dart';
import 'package:flutter_matter/src/utils/specifyplatformexception.dart';
import 'package:flutter_test/flutter_test.dart';

class TestClass with SpecifyPlatfromException {}

void main() {
  final sut = TestClass();

  group('catchSpecifyRethrowAsync', () {
    test('when code is -1 should throw GeneralException', () async {
      await check(sut.catchSpecifyRethrow(() => Future.error(
            PlatformException(code: '-1', message: 'error 123'),
          ))).throws<GeneralException>(
        it()..has((p0) => p0.message, 'message').equals('error 123'),
      );
    });

    test('when code is -2 should throw UnsupportedPlatformException', () async {
      await check(sut.catchSpecifyRethrow(() => Future.error(
            PlatformException(code: '-2', message: 'error 123'),
          ))).throws<UnsupportedPlatformException>(
        it()..has((p0) => p0.message, 'message').equals('error 123'),
      );
    });

    test('when code is -3 should throw UserCancelledException', () async {
      await check(sut.catchSpecifyRethrow(() => Future.error(
            PlatformException(code: '-3', message: 'error 123'),
          ))).throws<UserCancelledException>(
        it()..has((p0) => p0.message, 'message').equals('error 123'),
      );
    });

    test('when code is -4 should throw TimeoutException', () async {
      await check(sut.catchSpecifyRethrow(() => Future.error(
            PlatformException(code: '-4', message: 'error 123'),
          ))).throws<TimeoutException>(
        it()..has((p0) => p0.message, 'message').equals('error 123'),
      );
    });

    test('when code isn\'t defined should rethrow', () async {
      await check(sut.catchSpecifyRethrow(() => Future.error(
            PlatformException(code: 'not defined', message: 'error 123'),
          ))).throws<PlatformException>(
        it()..has((p0) => p0.message, 'message').equals('error 123'),
      );
    });

    test('when exception isn\'t a platform, exception should rethrow',
        () async {
      await check(sut.catchSpecifyRethrow(
        () => Future.error(
          Exception(),
        ),
      )).throws<Exception>();
    });

    test('when doesn\'t throw a exception should return value', () async {
      await check(sut.catchSpecifyRethrow(
        () => Future.value(
          123,
        ),
      )).completes(it()..equals(123));
    });

    test('should run sync functions', () async {
      await check(sut.catchSpecifyRethrow(
        () => 123,
      )).completes(it()..equals(123));
    });
  });

  group('catchSpecifyRethrowStream', () {
    test('should return stream values', () async {
      final stream = Stream.fromIterable([1, 2, 3]);

      await check(sut.catchSpecifyRethrowStream(stream)).withQueue.inOrder([
        it()..emits(it()..equals(1)),
        it()..emits(it()..equals(2)),
        it()..emits(it()..equals(3)),
        it()..isDone(),
      ]);
    });

    test('should return stream values', () async {
      final stream = Stream.fromIterable([1, 2, 3]);

      await check(sut.catchSpecifyRethrowStream(stream)).withQueue.inOrder([
        it()..emits(it()..equals(1)),
        it()..emits(it()..equals(2)),
        it()..emits(it()..equals(3)),
        it()..isDone(),
      ]);
    });

    test(
        'when error isn\'t a specified PlatformException, should emit the PlatformException',
        () async {
      final stream = Stream.error(
          PlatformException(code: 'not defined', message: 'error 123'));

      await check(sut.catchSpecifyRethrowStream(stream))
          .withQueue
          .emitsError<PlatformException>(it()
            ..has((p0) => p0.message, 'message').equals('error 123')
            ..has((p0) => p0.code, 'code').equals('not defined'));
    });

    test('when error any other expcetion, should emit the error', () async {
      final stream = Stream.error(Exception());

      await check(sut.catchSpecifyRethrowStream(stream))
          .withQueue
          .emitsError<Exception>();
    });

    test('when code is -1 should emit GeneralException', () async {
      final stream =
          Stream.error(PlatformException(code: '-1', message: 'error 123'));

      await check(sut.catchSpecifyRethrowStream(stream))
          .withQueue
          .emitsError<GeneralException>(
              it()..has((p0) => p0.message, 'message').equals('error 123'));
    });

    test('when code is -2 should emit UnsupportedPlatformException', () async {
      final stream =
          Stream.error(PlatformException(code: '-2', message: 'error 123'));

      await check(sut.catchSpecifyRethrowStream(stream))
          .withQueue
          .emitsError<UnsupportedPlatformException>(
              it()..has((p0) => p0.message, 'message').equals('error 123'));
    });

    test('when code is -3 should emit UserCancelledException', () async {
      final stream =
          Stream.error(PlatformException(code: '-3', message: 'error 123'));

      await check(sut.catchSpecifyRethrowStream(stream))
          .withQueue
          .emitsError<UserCancelledException>(
              it()..has((p0) => p0.message, 'message').equals('error 123'));
    });

    test('when code is -4 should emit TimeoutException', () async {
      final stream =
          Stream.error(PlatformException(code: '-4', message: 'error 123'));

      await check(sut.catchSpecifyRethrowStream(stream))
          .withQueue
          .emitsError<TimeoutException>(
              it()..has((p0) => p0.message, 'message').equals('error 123'));
    });
  });
}
