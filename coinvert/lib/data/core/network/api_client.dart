import 'package:coinvert/config.dart';
import 'package:coinvert/data/core/network/interceptors/logger_dio_intercpetor.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;
  final String baseUrl = "${Config.baseUrl}${Config.keyUrl}";

  ApiClient(this.dio) {
    dio.options.baseUrl = baseUrl;
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(seconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 5)
      ..options.sendTimeout = const Duration(seconds: 5);
    dio.interceptors.add(LoggerDioInterceptor());
  }

  //prima chiamata latest/USD endpoint
}
