import 'package:flutter/material.dart';
import 'package:meals_app/data/meal.dart';
import 'package:meals_app/widget/meal_item.dart';

class CategoryMealScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  CategoryMealScreen(
    this.meal
  );
  List<Meal> meal;

  @override
  Widget build(BuildContext context) {
    final routesArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryID = routesArgs['id'];
    final titleCatgory = routesArgs['title'];
    final categoryMeal = meal;

    final filteredMeal = categoryMeal.where((element) {
      return element.categories.contains(categoryID);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipes',
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: filteredMeal.length,
          itemBuilder: (ctx, index) {
          return MealItem(
              id:  filteredMeal[index].id,
              title: filteredMeal[index].title,
              imageUrl: filteredMeal[index].imageUrl,
              duration: filteredMeal[index].duration,
              complexity: filteredMeal[index].complexity,
              affordability: filteredMeal[index].affordability);
        }),
      ),
    );
  }
}
