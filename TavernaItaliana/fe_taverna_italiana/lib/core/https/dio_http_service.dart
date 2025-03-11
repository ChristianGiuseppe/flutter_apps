import 'dart:io';

import 'package:dio/dio.dart';
import 'package:taverna_italiana/core/configuration.dart';
import 'package:taverna_italiana/core/https/http_service.dart';

class DioHttpService implements HttpService {
  DioHttpService({Dio? dioOverride}) {
    dio = dioOverride ?? Dio(baseOptions);
  }

  late final Dio dio;

  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => Configuration.apiBaseUrl;

  @override
  Map<String, String> headers = {
    'accept': 'application/json',
    'content-type': 'application/json'
  };

  @override
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
    String? customBaseUrl,
  }) async {
    final Response<dynamic> response = await dio.get<Map<String, dynamic>>(
      endpoint,
      queryParameters: queryParameters,
    );
    if (response.data == null || response.statusCode != 200) {
      throw HttpException(
        response.statusMessage!,
      );
    }

    return response.data as Map<String, dynamic>;
  }

  @override
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response<dynamic> response = await dio.post<Map<String, dynamic>>(
      endpoint,
      queryParameters: queryParameters,
    );

    if (response.data == null || response.statusCode != 200) {
      throw HttpException(
        response.statusMessage!,
      );
    }

    return response.data;
  }

  @override
  Future<dynamic> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<dynamic> put() {
    // TODO: implement put
    throw UnimplementedError();
  }
}
