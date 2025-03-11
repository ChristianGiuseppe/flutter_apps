class Recipe {
  final String name;
  final String category;
  final String imgUrl;
  final String region;
  final String city;
  final List<Ingredient> ingredients;
  final List<String> steps;

  Recipe({
    required this.name,
    required this.category,
    required this.imgUrl,
    required this.region,
    required this.city,
    required this.ingredients,
    required this.steps,
  });
}

class Ingredient {
  final String name;
  final num quantity;
  final String unit;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });
}
