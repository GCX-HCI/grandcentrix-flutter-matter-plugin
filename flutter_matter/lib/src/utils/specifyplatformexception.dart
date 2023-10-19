import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_matter/src/exceptions/flutter_matter_exceptions.dart';

/// Helper mixin to convert [PlatformException] to the specific [FlutterMatterException]
mixin SpecifyPlatfromException {
  /// Runs the function `f`, catches a [PlatformException] and throws a [FlutterMatterException] or rethrows the exception
  Future<T> catchSpecifyRethrow<T>(FutureOr<T> Function() f) async {
    try {
      return await f();
    } on PlatformException catch (e) {
      switch (e.code) {
        case '-1':
          throw GeneralException(e.message);
        case '-2':
          throw UnsupportedPlatformException(e.message);
        case '-3':
          throw UserCancelledException(e.message);
        case '-4':
          throw TimeoutException(e.message);
        default:
          rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Get the stream from function `f`, handles the error and emits a [FlutterMatterException], when error is a [PlatformException] or emit the same error
  Stream<T> catchSpecifyRethrowStream<T>(Stream<T> s) {
    var transformer = StreamTransformer<T, T>.fromHandlers(
      handleData: (data, sink) => sink.add(data),
      handleError: (error, stackTrace, sink) => switch (error) {
        PlatformException(code: var c, message: var m) => switch (c) {
            '-1' => sink.addError(GeneralException(m), stackTrace),
            '-2' => sink.addError(UnsupportedPlatformException(m), stackTrace),
            '-3' => sink.addError(UserCancelledException(m), stackTrace),
            '-4' => sink.addError(TimeoutException(m), stackTrace),
            _ => sink.addError(error, stackTrace),
          },
        _ => sink.addError(error, stackTrace),
      },
      handleDone: (sink) => sink.close(),
    );

    return s.transform(transformer);
  }
}
