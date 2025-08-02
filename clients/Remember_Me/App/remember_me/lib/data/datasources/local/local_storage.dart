import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/errors/exceptions.dart';

class LocalStorage {
  static SharedPreferences? _preferences;

  /// Initialize shared preferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Get shared preferences instance
  SharedPreferences get _prefs {
    if (_preferences == null) {
      throw CacheException('SharedPreferences not initialized. Call LocalStorage.init() first.');
    }
    return _preferences!;
  }

  /// Save string value
  Future<bool> saveString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      throw CacheException('Failed to save string: $e');
    }
  }

  /// Get string value
  Future<String?> getString(String key) async {
    try {
      return _prefs.getString(key);
    } catch (e) {
      throw CacheException('Failed to get string: $e');
    }
  }

  /// Save int value
  Future<bool> saveInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e) {
      throw CacheException('Failed to save int: $e');
    }
  }

  /// Get int value
  Future<int?> getInt(String key) async {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      throw CacheException('Failed to get int: $e');
    }
  }

  /// Save bool value
  Future<bool> saveBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      throw CacheException('Failed to save bool: $e');
    }
  }

  /// Get bool value
  Future<bool?> getBool(String key) async {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      throw CacheException('Failed to get bool: $e');
    }
  }

  /// Save double value
  Future<bool> saveDouble(String key, double value) async {
    try {
      return await _prefs.setDouble(key, value);
    } catch (e) {
      throw CacheException('Failed to save double: $e');
    }
  }

  /// Get double value
  Future<double?> getDouble(String key) async {
    try {
      return _prefs.getDouble(key);
    } catch (e) {
      throw CacheException('Failed to get double: $e');
    }
  }

  /// Save list of strings
  Future<bool> saveStringList(String key, List<String> value) async {
    try {
      return await _prefs.setStringList(key, value);
    } catch (e) {
      throw CacheException('Failed to save string list: $e');
    }
  }

  /// Get list of strings
  Future<List<String>?> getStringList(String key) async {
    try {
      return _prefs.getStringList(key);
    } catch (e) {
      throw CacheException('Failed to get string list: $e');
    }
  }

  /// Remove value by key
  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      throw CacheException('Failed to remove key: $e');
    }
  }

  /// Clear all stored values
  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      throw CacheException('Failed to clear storage: $e');
    }
  }

  /// Check if key exists
  Future<bool> containsKey(String key) async {
    try {
      return _prefs.containsKey(key);
    } catch (e) {
      throw CacheException('Failed to check key existence: $e');
    }
  }

  /// Get all keys
  Future<Set<String>> getAllKeys() async {
    try {
      return _prefs.getKeys();
    } catch (e) {
      throw CacheException('Failed to get all keys: $e');
    }
  }
}