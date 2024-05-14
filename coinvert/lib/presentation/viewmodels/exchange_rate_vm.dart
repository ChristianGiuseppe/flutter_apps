import 'package:coinvert/data/repository/exchange_repository.dart';
import 'package:flutter/widgets.dart';

class ExchangeRateViewModel extends ChangeNotifier {
  final ExchangeRepository _exchangeRateRepository;
  Map<String, double> rates = {};
  List<String> currencies = ['USD'];
  DateTime lastUpdated = DateTime.now();

  String currentCurrency = 'USD';
  double currentRate = 1.0;
  double amount = 1;

  ExchangeRateViewModel(this._exchangeRateRepository) {
    fetchExchangeRate();
  }

  Future<void> fetchExchangeRate() async {
    final result =
        await _exchangeRateRepository.getExchangeRates(currentCurrency);
    result.fold((l) => null, (r) {
      lastUpdated = DateTime.fromMillisecondsSinceEpoch(r.timeLastUpdateUnix);
      currencies = r.conversionRates.keys.toList();
      rates = r.conversionRates
          .map((key, value) => MapEntry(key, value.toDouble()));
    });
    notifyListeners();
  }

  updateAmount(double newAmount) {
    amount = newAmount;
    notifyListeners();
  }

  updateCurrency(String newCurrency) {
    if (rates[newCurrency] != null) {
      currentCurrency = newCurrency;
      currentRate = rates[newCurrency]!;
      notifyListeners();
    }
  }

  double convert(String toCurrency) {
    if (rates[currentCurrency] != null && rates[toCurrency] != null) {
      double rateFrom = rates[currentCurrency]!;
      double rateTo = rates[toCurrency]!;
      return amount * (rateTo / rateFrom);
    }
    return 0;
  }
}
