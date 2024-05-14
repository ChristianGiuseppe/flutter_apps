import 'package:coinvert/data/core/network/api_client.dart';
import 'package:coinvert/data/core/network/apis.dart';
import 'package:coinvert/data/core/network/error/failures.dart';
import 'package:coinvert/data/models/responses/exchange_rate_model.dart';
import 'package:dio/dio.dart';

/// A contract for the [ExchangeRemoteDataSource] class.
/// The [ExchangeRemoteDataSource] class is a wrapper around the network layer.
/// It is responsible for making API calls to the exchange rate API.
abstract class ExchangeRemoteDataSource {
  /// Calls the [baseUrl]/latest/USD endpoint.
  /// Throws a [DioException] for all error codes.
  Future<ExchangeRateModel> getExchangeRates(String currency);
}

class ExchangeRemoteDataSourceImpl extends ExchangeRemoteDataSource {
  final ApiClient apiClient;
  ExchangeRemoteDataSourceImpl(
    this.apiClient,
  );
  @override
  Future<ExchangeRateModel> getExchangeRates(String currency) async {
    try {
      final response = (await apiClient.dio.get('${Apis.latest}/$currency'));
      if (response.statusCode == 200 && response.data != null) {
        return ExchangeRateModel.fromJson(response.data);
      }
      throw DioException(
          requestOptions: response.requestOptions, response: response);
    } on DioException {
      throw const ServerFailure("Unknown Error");
    }
  }
}
