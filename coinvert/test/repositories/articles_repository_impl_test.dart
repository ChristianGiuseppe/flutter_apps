import 'package:coinvert/data/datasources/local/exchange_local_datasource.dart';
import 'package:coinvert/data/datasources/remote/exchange_remote_datasource.dart';
import 'package:coinvert/data/models/responses/exchange_rate_model.dart';
import 'package:coinvert/data/repository/exchange_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'articles_repository_impl_test.mocks.dart';
import 'mock_data/data_exchange.dart';

@GenerateMocks([ExchangeRemoteDataSource, ExchangeLocalDataSource])
void main() {
  const String currency = 'USD';

  late MockExchangeRemoteDataSource exchangeRemoteDataSource;
  late MockExchangeLocalDataSource exchangeLocalDataSource;

  late ExchangeRepositoryImpl exchangeRepository;

  late ExchangeRateModel exchangeRateModel;

  setUp(() {
    exchangeRateModel = ExchangeRateModel.fromJson(jsonResponse);
    exchangeRemoteDataSource = MockExchangeRemoteDataSource();
    exchangeLocalDataSource = MockExchangeLocalDataSource();
    exchangeRepository = ExchangeRepositoryImpl(
        exchangeRemoteDataSource, exchangeLocalDataSource);
  });

  test("Get all conversionRates - failed case", () async {
    // Stubbing del metodo getExchangeRates del mock ExchangeRemoteDataSource
    when(exchangeRemoteDataSource.getExchangeRates(currency))
        .thenAnswer((_) async {
      return exchangeRateModel;
    });

    var result = await exchangeRepository.fromRemote(currency);
    expect(result, equals(exchangeRateModel));
  });
}
