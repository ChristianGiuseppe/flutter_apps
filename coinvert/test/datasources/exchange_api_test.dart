import 'package:coinvert/config.dart';
import 'package:coinvert/data/core/network/api_client.dart';
import 'package:coinvert/data/core/network/apis.dart';
import 'package:coinvert/data/core/network/error/failures.dart';
import 'package:coinvert/data/datasources/remote/exchange_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exchange_api_test.mocks.dart';

@GenerateMocks([Dio, ApiClient])
void main() {
  String currency = 'USD';
  late MockApiClient apiClient;
  late MockDio mockDio;

  late ExchangeRemoteDataSource exchangeRemoteDataSource;
  final BaseOptions baseOptions = BaseOptions();
  baseOptions.baseUrl = "${Config.baseUrl}${Config.keyUrl}";

  setUp(() {
    mockDio = MockDio();
    when(mockDio.options)
        .thenReturn(baseOptions); // Stubbing del metodo options del mock Dio
    apiClient = MockApiClient();
    when(apiClient.dio)
        .thenReturn(mockDio); // Stubbing del metodo dio del mock ApiClient
    exchangeRemoteDataSource = ExchangeRemoteDataSourceImpl(apiClient);
  });

  group("Exchange API", () {
    test("Get all conversionRates - failed case", () async {
      when(mockDio.get('${Apis.latest}/$currency')).thenAnswer((_) async {
        return Response(statusCode: 400, requestOptions: RequestOptions());
      });

      var result;
      try {
        result = await exchangeRemoteDataSource.getExchangeRates(currency);
      } catch (e) {
        result = e;
      }

      expect(result, const ServerFailure("Unknown Error"));
    });
  });
}
