import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taverna_italiana/core/cache/local_cache_service.dart';
import 'package:taverna_italiana/core/cache/shared_preferences_local_cache.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((_) {
  throw UnimplementedError(
      'sharedPreferencesProvider deve essere sovrascritto');
});

final sharedPreferencesLocalCacheProvider = Provider<LocalCacheService>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedPreferencesLocalCache(sharedPrefs);
});
