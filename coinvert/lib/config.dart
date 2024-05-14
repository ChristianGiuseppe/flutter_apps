import 'package:flutter/foundation.dart';

class Config {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: "https://v6.exchangerate-api.com/v6/",
  );

  static const String keyUrl = String.fromEnvironment(
    'KEY_URL',
    defaultValue: "",
  );

  static const bool semanticDebugging = bool.fromEnvironment(
    'ENVIRONMENT_PROD',
    defaultValue: false,
  );

  static bool isProd = semanticDebugging || kDebugMode;
}
