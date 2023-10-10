import 'dart:js_util' as js_util;
import 'dart:async';

import 'request.dart';
import 'response.dart';
import 'package:typings/core.dart' as interop;

import 'interop/promise_interop.dart';

class FetchEvent {
  final interop.FetchEvent _delegate;
  FetchEvent._(this._delegate);

  String get type => _delegate.type;
  Request get request => _delegate.request;

  void respondWith(FutureOr<Response> response) {
    return _delegate.respondWithPromise(Future.value(response));
  }

  void waitUntil(FutureOr<void> future) {
    return _delegate.waitUntilPromise(Future(() async {
      await future;
    }));
  }
}

extension on interop.FetchEvent {
  /// This is a workaround for the fact that the `respondWith` method is
  /// probably checking for `instanceof Promise` instead of `then` method,
  /// so we force the incoming Future to be a Promise so the type is valid.
  void respondWithPromise(Future<interop.Response> r) =>
      js_util.callMethod(this, 'respondWith', [futureToPromise(r)]);

  void waitUntilPromise(Future<void> r) =>
      js_util.callMethod(this, 'waitUntil', [futureToPromise(r)]);
}

FetchEvent fetchEventFromJsObject(interop.FetchEvent fetchEvent) {
  return FetchEvent._(fetchEvent);
}
