import 'package:coinvert/data/core/local/shared_manager.dart';
import 'package:coinvert/data/core/network/api_client.dart';
import 'package:coinvert/data/datasources/local/exchange_local_datasource.dart';
import 'package:coinvert/data/datasources/remote/exchange_remote_datasource.dart';
import 'package:coinvert/data/repository/exchange_repository.dart';
import 'package:coinvert/presentation/viewmodels/exchange_rate_vm.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> setupInjector() async {
  //MARK: Core
  injector.registerLazySingleton<Dio>(() => Dio());
  injector.registerLazySingleton(() => ApiClient(injector()));
  injector.registerSingletonAsync<Preference>(() async {
    var prefs = Preference.instance;
    await prefs.init();
    return prefs;
  });

  //MARK: Datasources Local
  injector.registerLazySingleton<ExchangeLocalDataSource>(
      () => ExchangeLocalDataSourceImpl(injector<Preference>()));

  //MARK: Datasources Remote
  injector.registerLazySingleton<ExchangeRemoteDataSource>(
      () => ExchangeRemoteDataSourceImpl(injector()));

  //MARK: Repositories
  injector.registerLazySingleton<ExchangeRepository>(
      () => ExchangeRepositoryImpl(injector(), injector()));

  //MARK: ViewModels

  injector.registerFactory(() => ExchangeRateViewModel(injector()));
}
