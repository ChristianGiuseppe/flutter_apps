import 'package:taverna_italiana/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> fetchRecipes({bool forceRefresh = false});
}
