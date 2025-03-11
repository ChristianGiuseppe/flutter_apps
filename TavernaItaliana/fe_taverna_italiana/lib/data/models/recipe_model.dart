import 'dart:convert';
import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    required super.name,
    required super.category,
    required super.imgUrl,
    required super.region,
    required super.city,
    required super.steps,
    required List<IngredientModel> ingredients,
  }) : super(ingredients: ingredients);

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      name: json['name'] as String,
      category: json['category'] as String,
      imgUrl: json['imgURL'] as String,
      region: json['region'] as String,
      city: json['city'] as String,
      steps: List<String>.from(json['steps']),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((ingredientJson) => IngredientModel.fromJson(ingredientJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'imgURL': imgUrl,
        'region': region,
        'city': city,
        'ingredients':
            ingredients.map((x) => (x as IngredientModel).toJson()).toList(),
        'steps': steps,
      };

  static List<RecipeModel> listFromJson(String jsonString) =>
      (jsonDecode(jsonString) as List<dynamic>)
          .map((e) => RecipeModel.fromJson(e))
          .toList();

  static String listToJson(List<RecipeModel> recipes) =>
      jsonEncode(recipes.map((e) => e.toJson()).toList());
}

class IngredientModel extends Ingredient {
  IngredientModel({
    required super.name,
    required super.quantity,
    required super.unit,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      IngredientModel(
        name: json['name'] as String,
        quantity: (json['quantity'] as num?) ?? 0,
        unit: json['unit'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'unit': unit,
      };
}
