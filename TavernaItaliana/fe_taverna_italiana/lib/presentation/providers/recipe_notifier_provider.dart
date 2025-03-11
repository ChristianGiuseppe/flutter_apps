import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taverna_italiana/data/repositories/recipe_repository_impl.dart';
import 'package:taverna_italiana/domain/entities/recipe.dart';

final recipeNotifierProvider =
    AsyncNotifierProvider<RecipeNotifier, List<Recipe>>(RecipeNotifier.new);

class RecipeNotifier extends AsyncNotifier<List<Recipe>> {
  List<Recipe> _allRecipes = [];
  @override
  Future<List<Recipe>> build() async {
    _allRecipes = await fetchRecipes();
    return _allRecipes;
  }

  Future<List<Recipe>> fetchRecipes({forceRefresh = false}) async {
    state = const AsyncLoading();
    final repository = ref.watch(recipeRepositoryProvider);
    _allRecipes = await repository.fetchRecipes(forceRefresh: forceRefresh);
    return _allRecipes;
  }

  void filterByCategory(String category) {
    _updateState(() {
      if (category == 'Tutti') {
        return _allRecipes;
      }
      final filtredList =
          _allRecipes.where((r) => r.category == category).toList();
      return filtredList;
    });
  }

  void _updateState(List<Recipe> Function() filter) {
    state = AsyncData(filter());
  }

  Future<void> refreshRecipes() async {
    state = const AsyncLoading();
    _allRecipes = await fetchRecipes(forceRefresh: true);
    state = await AsyncValue.guard(() => build());
  }
}
