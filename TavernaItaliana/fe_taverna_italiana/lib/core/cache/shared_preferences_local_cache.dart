import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_cache_service.dart'; // Assicurati di avere definito l'abstract class in questo file

class SharedPreferencesLocalCache implements LocalCacheService {
  final SharedPreferences sharedPreferences;

  SharedPreferencesLocalCache(this.sharedPreferences);

  @override
  Future<bool> saveData<T>(String key, T data) async {
    try {
      if (data is String) {
        return sharedPreferences.setString(key, data);
      } else if (data is int) {
        return sharedPreferences.setInt(key, data);
      } else if (data is double) {
        return sharedPreferences.setDouble(key, data);
      } else if (data is bool) {
        return sharedPreferences.setBool(key, data);
      } else {
        final jsonString = jsonEncode(data);
        return sharedPreferences.setString(key, jsonString);
      }
    } catch (e) {
      log('Error saving data for key "$key": $e');
      return false;
    }
  }

  @override
  Future<T?> restoreData<T>(String key) async {
    try {
      if (T == String) {
        return sharedPreferences.getString(key) as T?;
      } else if (T == int) {
        return sharedPreferences.getInt(key) as T?;
      } else if (T == double) {
        return sharedPreferences.getDouble(key) as T?;
      } else if (T == bool) {
        return sharedPreferences.getBool(key) as T?;
      } else {
        final jsonString = sharedPreferences.getString(key);
        if (jsonString != null) {
          return jsonDecode(jsonString) as T;
        }
      }
    } catch (e) {
      log('Error restoring data for key "$key": $e');
    }
    return null;
  }

  @override
  Future<bool> removeData(String key) async {
    try {
      return sharedPreferences.remove(key);
    } catch (e) {
      log('Error removing data for key "$key": $e');
      return false;
    }
  }

  @override
  Future<bool> clearData() async {
    try {
      return sharedPreferences.clear();
    } catch (e) {
      log('Error clearing data: $e');
      return false;
    }
  }
}
