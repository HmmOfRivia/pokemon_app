library storage;

class StorageException implements Exception {
  const StorageException(this.error, [this.stackTrace]);

  final Object error;

  final StackTrace? stackTrace;
}

/// A Dart Storage Client Interface
abstract class Storage {
  Future<String?> read({required String key});

  Future<List<String>?> readStringList({required String key});

  Future<void> write({required String key, required String value});

  Future<void> writeStringList({
    required String key,
    required List<String> value,
  });

  Future<void> delete({required String key});

  Future<void> clear();
}
