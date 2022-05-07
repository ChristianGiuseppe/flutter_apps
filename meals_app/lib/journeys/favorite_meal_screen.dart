import 'package:flutter/material.dart';
import 'package:meals_app/data/meal.dart';
import 'package:meals_app/widget/meal_item.dart';

class FavoriteMealScreen extends StatelessWidget {
  FavoriteMealScreen({ Key? key, required this.favorite}) : super(key: key);
  final List<Meal> favorite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: favorite.length,
          itemBuilder: (ctx, index) {
          return MealItem(
              id:  favorite[index].id,
              title: favorite[index].title,
              imageUrl: favorite[index].imageUrl,
              duration: favorite[index].duration,
              complexity: favorite[index].complexity,
              affordability: favorite[index].affordability);
        }),
      ),
    );
  }
}