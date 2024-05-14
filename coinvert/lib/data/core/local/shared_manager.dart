import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  late SharedPreferences _prefs;
  final Map<String, dynamic> _memoryPrefs = {};

  static final Preference _instance = Preference._privateConstructor();
  static Preference get instance => _instance;

  Preference._privateConstructor();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setString(String key, String value) {
    _prefs.setString(key, value);
    _memoryPrefs[key] = value;
  }

  void setInt(String key, int value) {
    _prefs.setInt(key, value);
    _memoryPrefs[key] = value;
  }

  void setDouble(String key, double value) {
    _prefs.setDouble(key, value);
    _memoryPrefs[key] = value;
  }

  void setBool(String key, bool value) {
    _prefs.setBool(key, value);
    _memoryPrefs[key] = value;
  }

  String? getString(String key, {String? def}) {
    return _memoryPrefs[key] ?? _prefs.getString(key) ?? def;
  }

  int getInt(String key, {int? def}) {
    return _memoryPrefs[key] ?? _prefs.getInt(key) ?? def ?? 0;
  }

  double getDouble(String key, {double? def}) {
    return _memoryPrefs[key] ?? _prefs.getDouble(key) ?? def ?? 0.0;
  }

  bool getBool(String key, {bool def = false}) {
    return _memoryPrefs[key] ?? _prefs.getBool(key) ?? def;
  }
}
