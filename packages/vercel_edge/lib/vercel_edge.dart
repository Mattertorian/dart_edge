import 'package:edge_runtime/edge_runtime.dart';
import 'package:edge_runtime/src/interop/promise_interop.dart';
import 'package:edge_runtime/src/request.dart';
import 'package:edge_runtime/src/response.dart';
import 'package:js/js.dart';
import 'package:typings/core.dart' as interop;

export './public/request.dart';

@JS('__dartVercelFetchHandler')
external set __dartVercelFetchHandler(
    Promise<interop.Response> Function(interop.Request req) f);

class VercelEdge {
  final FutureOr<Response> Function(Request request)? fetch;

  VercelEdge({
    this.fetch,
  }) {
    // Setup the runtime environment.
    setupRuntime();

    if (fetch != null) {
      __dartVercelFetchHandler = allowInterop((interop.Request request) {
        return futureToPromise(Future(() async {
          final response = await fetch!(requestFromJsObject(request));
          return response.delegate;
        }));
      });
    }
  }
}
