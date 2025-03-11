import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taverna_italiana/core/https/dio_http_service.dart';
import 'package:taverna_italiana/core/https/http_service.dart';

final httpServiceProvider = Provider<HttpService>((ref) {
  return DioHttpService();
});
