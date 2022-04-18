import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';

class CategoryMealScreen extends StatelessWidget {
  static const routeName = '/category-meals';
   CategoryMealScreen();
 /* CategoryMealScreen(
      {Key? key, required this.categoryID, required this.titleCatgory});
  final String categoryID;
  final String titleCatgory;*/

  @override
  Widget build(BuildContext context) {
    final routesArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryID = routesArgs['id'];
    final titleCatgory = routesArgs['title'];
    final categoryMeal = DUMMY_MEALS;

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
        child: ListView.builder(itemBuilder: (ctx, index) {
          return Card(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Text(filteredMeal[index].title),
              ),
            ),
          );
        }),
      ),
    );
  }
}
