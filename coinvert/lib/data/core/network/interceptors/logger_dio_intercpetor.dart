import 'dart:convert';

import 'package:coinvert/data/core/utils/log/log_utils.dart';
import 'package:dio/dio.dart';

class LoggerDioInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    // MARK: Da implementare i flavor
    //if (FlavorConfig.instance.flavor == Flavor.DEVELOPMENT) {
    // Log request details
    logDebug(
        '\n\n\n\n.........................................................................');
    logDebug('onRequest: ${options.method} request => $requestPath',
        level: Level.info);
    logDebug('onRequest: Request Headers => ${options.headers}',
        level: Level.info);
    logDebug('onRequest: Request Data => ${_prettyJsonEncode(options.data)}',
        level: Level.info);
    // }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // MARK: Da implementare i flavor
    //if (FlavorConfig.instance.flavor == Flavor.DEVELOPMENT) {
    logDebug(
        'onResponse: StatusCode: ${response.statusCode}, Data: ${_prettyJsonEncode(response.data)}',
        level: Level.debug); // Log formatted response data
    logDebug(
        '.........................................................................\n\n\n\n');
    // }

    super.onResponse(response, handler);
  }

  String _prettyJsonEncode(dynamic data) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      final jsonString = encoder.convert(data);
      return jsonString;
    } catch (e) {
      return data.toString();
    }
  }
}
