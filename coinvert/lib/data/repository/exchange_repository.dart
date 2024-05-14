import 'package:coinvert/data/core/network/error/failures.dart';
import 'package:coinvert/data/datasources/local/exchange_local_datasource.dart';
import 'package:coinvert/data/datasources/remote/exchange_remote_datasource.dart';
import 'package:coinvert/data/models/responses/exchange_rate_model.dart';
import 'package:dartz/dartz.dart';

abstract class ExchangeRepository {
  Future<Either<Failure, ExchangeRateModel>> getExchangeRates(String currency);
}

class ExchangeRepositoryImpl extends ExchangeRepository {
  final ExchangeRemoteDataSource exchangeRemoteDataSource;
  final ExchangeLocalDataSource exchangeLocalDataSource;

  ExchangeRepositoryImpl(
      this.exchangeRemoteDataSource, this.exchangeLocalDataSource);
  @override
  Future<Either<Failure, ExchangeRateModel>> getExchangeRates(
      String currency) async {
    try {
      var localData = await fromLocal();
      if (localData != null) {
        return Right(localData);
      }
      var remoteData = await fromRemote(currency);
      return right(remoteData);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.errorMessage));
    } on ConnectionFailure catch (e) {
      return Left(ConnectionFailure(e.errorMessage));
    }
  }

  Future<ExchangeRateModel?> fromLocal() async {
    return await exchangeLocalDataSource.getExchangeRates();
  }

  Future<ExchangeRateModel> fromRemote(String currency) async {
    final remoteData =
        await exchangeRemoteDataSource.getExchangeRates(currency);
    await exchangeLocalDataSource.setExchangeRates(remoteData);
    return remoteData;
  }
}
