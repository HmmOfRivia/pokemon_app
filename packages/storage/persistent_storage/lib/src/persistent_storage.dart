import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';

class PersistentStorage implements Storage {
  const PersistentStorage({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<String?> read({required String key}) async {
    try {
      return _sharedPreferences.getString(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      await _sharedPreferences.setString(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await _sharedPreferences.remove(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _sharedPreferences.clear();
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<List<String>?> readStringList({required String key}) async {
    try {
      return _sharedPreferences.getStringList(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> writeStringList({
    required String key,
    required List<String> value,
  }) async {
    try {
      await _sharedPreferences.setStringList(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }
}
