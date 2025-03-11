import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taverna_italiana/core/cache/local_cache_service.dart';
import 'package:taverna_italiana/core/cache/local_cache_service_provider.dart';
import 'package:taverna_italiana/core/cache/shared_preferences_local_cache.dart';
import 'package:taverna_italiana/data/models/recipe_model.dart';

final recipeLocalDataSourceProvider = Provider<RecipeDataSourceLocal>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  final cacheService = SharedPreferencesLocalCache(sharedPrefs);
  return RecipeDataSourceLocal(cacheService);
});

class RecipeDataSourceLocal {
  final LocalCacheService localStorage;
  static const String recipesKey = 'cached_recipes';

  RecipeDataSourceLocal(this.localStorage);

  Future<List<RecipeModel>?> getRecipes() async {
    final jsonData = await localStorage.restoreData<List<dynamic>>(recipesKey);
    if (jsonData == null) return null;
    return jsonData.map((json) => RecipeModel.fromJson(json)).toList();
  }

  Future<bool> cacheRecipes(List<RecipeModel> recipes) async {
    final jsonList = recipes.map((r) => r.toJson()).toList();
    return await localStorage.saveData(recipesKey, jsonList);
  }
}
