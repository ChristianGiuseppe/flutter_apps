import 'dart:convert';

import 'package:coinvert/data/core/local/shared_keys.dart';
import 'package:coinvert/data/core/local/shared_manager.dart';
import 'package:coinvert/data/models/responses/exchange_rate_model.dart';

/// A contract for the [ExchangeLocalDataSource] class.
/// The [ExchangeLocalDataSource] class is a wrapper around the local data layer.
/// It is responsible for making calls to the local database.
abstract class ExchangeLocalDataSource {
  Future<ExchangeRateModel?> getExchangeRates();
  Future<void> setExchangeRates(ExchangeRateModel exchangeRateModel);
}

class ExchangeLocalDataSourceImpl extends ExchangeLocalDataSource {
  final Preference _preferences;
  ExchangeLocalDataSourceImpl(this._preferences);
  @override
  Future<ExchangeRateModel?> getExchangeRates() async {
    var result = _preferences.getString(SharedKeys.exchangeRates);
    if (result != null) {
      final decodeMap = jsonDecode(result);
      return ExchangeRateModel.fromJson(decodeMap);
    }
    return null;
  }

  @override
  Future<void> setExchangeRates(ExchangeRateModel exchangeRateModel) async {
    _preferences.setString(
        SharedKeys.exchangeRates, jsonEncode(exchangeRateModel));
  }
}
