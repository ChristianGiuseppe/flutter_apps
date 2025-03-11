import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taverna_italiana/data/data_source/local/recipe_data_source_local.dart';
import 'package:taverna_italiana/data/data_source/remote/recipe_data_source_remote.dart';
import 'package:taverna_italiana/domain/entities/recipe.dart';
import 'package:taverna_italiana/domain/repositories/recipe_repository.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  final localDataSource = ref.watch(recipeLocalDataSourceProvider);
  final remoteDataSource = ref.watch(recipeDataSourceRemoteProvider);
  return RecipeRepositoryImpl(localDataSource, remoteDataSource);
});

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDataSourceLocal recipeDataSourceLocal;
  final RecipeDataSourceRemote recipeDataSourceRemote;

  RecipeRepositoryImpl(this.recipeDataSourceLocal, this.recipeDataSourceRemote);

  @override
  Future<List<Recipe>> fetchRecipes({bool forceRefresh = false}) async {
    try {
      final cachedRecipes = await recipeDataSourceLocal.getRecipes();
      if (!forceRefresh && cachedRecipes != null && cachedRecipes.isNotEmpty) {
        return cachedRecipes;
      }
      final result = await recipeDataSourceRemote.fetchRecipes();
      await recipeDataSourceLocal.cacheRecipes(result);

      return result;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to fetch recipes');
    }
  }
}
