import 'interop/deno_interop.dart' as interop;

class Deno {
  static get env => Env._(interop.Env());

  static Future<TcpConn> connect({
    required int port,
    String hostname = '127.0.0.1',
    String transport = 'tcp',
  }) async =>
      TcpConn();

  static connectTls({
    required int port,
    String hostname = '127.0.0.1',
    Iterable<String>? caCerts,
    String? certChain,
    String? privateKey,
    Iterable<String>? alpnProtocols,
  }) =>
      {};

  static startTls({
    String hostname = '127.0.0.1',
    Iterable<String>? caCerts,
    Iterable<String>? alpnProtocols,
  }) =>
      {};

  // Multiple types
  static resolveDns() => {};

  static Uri cwd(Uri uri) => Uri.parse(interop.cwd());

  static Stream<DirEntry> readDir(Uri uri) async* {
    final asyncIterator = interop.readDir(uri.toString());
    while (true) {
      final result = await asyncIterator.next();
      if (result.done) break;
      yield DirEntry._(result.value);
    }
  }

  static readFile(Uri uri) => {};

  // Options
  static readTextFile(Uri uri) => {};

  static open(
    Uri uri, {
    bool read = true,
    bool write = false,
    bool append = false,
    bool truncate = false,
    bool create = false,
    bool createNew = false,
    num? mode,
  }) =>
      {};

  static stat(Uri uri) => {};
  static lstat(Uri uri) => {};
  static Future<String> realPath(Uri uri) async => 'todo';
  static Future<String> readLink(Uri uri) async => 'todo';
}

class Env {
  final interop.Env _delegate;
  Env._(this._delegate);

  String? get(String key) => _delegate.get(key);
  void set(String key, String value) => _delegate.set(key, value);
  void delete(String key) => _delegate.delete(key);
  bool has(String key) => _delegate.has(key);

  // Probs needs dartify
  Map<String, String> toJson() => _delegate.toObject();
}

class TcpConn {}

class DirEntry {
  final interop.DirEntry _delegate;

  DirEntry._(this._delegate);
  String get name => _delegate.name;
  bool get isFile => _delegate.isFile;
  bool get isDirectory => _delegate.isDirectory;
  bool get isSymlink => _delegate.isSymlink;
}