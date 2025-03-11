import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taverna_italiana/core/cache/local_cache_service_provider.dart';
import 'package:taverna_italiana/presentation/pages/recipe_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ], child: const TavernaItalianaApp()));
}

class TavernaItalianaApp extends StatelessWidget {
  const TavernaItalianaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const RecipePage());
  }
}
