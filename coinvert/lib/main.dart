import 'package:coinvert/injector.dart';
import 'package:coinvert/presentation/screens/home_screen.dart';
import 'package:coinvert/presentation/viewmodels/exchange_rate_vm.dart';
import 'package:coinvert/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjector();
  await injector.allReady();
  runApp(
    ChangeNotifierProvider<ExchangeRateViewModel>(
      create: (context) => injector(),
      child: const CoinvertApp(),
    ),
  );
}

class CoinvertApp extends StatelessWidget {
  const CoinvertApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appThemeDataLight,
      darkTheme: appThemeDataDark,
      home: const HomeScreen(),
    );
  }
}
