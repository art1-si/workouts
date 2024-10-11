import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A storage class that allows to store and retrieve data for the client.
class NetworkClientStorage {
  const NetworkClientStorage._internal(this._sharedPreferences, this._secureStorage);

  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage;

  static NetworkClientStorage? _instance;

  static Future<NetworkClientStorage> instance() async {
    if (_instance == null) {
      final pref = await SharedPreferences.getInstance();
      final secureStorage = const FlutterSecureStorage();
      _instance = NetworkClientStorage._internal(pref, secureStorage);
    }
    return _instance!;
  }

  /// Allows to override the instance with a custom [SharedPreferences] object.
  /// This is intended for testing purposes only.
  @visibleForTesting
  static void overrideInstance(SharedPreferences sharedPreferences, FlutterSecureStorage secureStorage) {
    _instance = NetworkClientStorage._internal(sharedPreferences, secureStorage);
  }

  /// Stores a string value with a key.
  /// NOTE: You should not store sensitive data with this method. Instead, use [setSecret].
  Future<void> setString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  /// Retrieves a string value with a key.
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  /// Removes a string value with a key.
  Future<void> removeString(String key) async {
    await _sharedPreferences.remove(key);
  }

  /// Stores a secret value with a key.
  /// This method should be used to store sensitive data.
  Future<void> setSecret(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Retrieves a secret value with a key.
  Future<String?> getSecret(String key) async {
    return _secureStorage.read(key: key);
  }

  /// Removes a secret value with a key.
  Future<void> removeSecret(String key) async {
    await _secureStorage.delete(key: key);
  }
}
