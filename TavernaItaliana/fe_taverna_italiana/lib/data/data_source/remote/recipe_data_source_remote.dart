import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taverna_italiana/core/https/http_service.dart';
import 'package:taverna_italiana/core/https/http_service_provider.dart';
import 'package:taverna_italiana/data/models/recipe_model.dart';

final recipeDataSourceRemoteProvider = Provider<RecipeDataSourceRemote>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return RecipeDataSourceRemote(httpService);
});

class RecipeDataSourceRemote {
  final HttpService httpService;

  RecipeDataSourceRemote(this.httpService);

  Future<List<RecipeModel>> fetchRecipes() async {
    final response = await httpService.get('/recipes');

    final recipesJson = response["recipes"] as List<dynamic>;
    return recipesJson
        .map((recipeJson) =>
            RecipeModel.fromJson(recipeJson as Map<String, dynamic>))
        .toList();
  }
}
