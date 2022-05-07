import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/data/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/mealDetail';
  MealDetailScreen({Key? key, required this.setToogleFavorite, required this.isFavorite}) : super(key: key);
  final Function setToogleFavorite;
  final Function isFavorite;
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments;
    final categoryMeal = DUMMY_MEALS;
    final filteredMeal =
        categoryMeal.firstWhere((element) => element.id == mealId);

    return Scaffold(
        appBar: AppBar(title: Text("${filteredMeal.title}")),
        floatingActionButton: FloatingActionButton(
          child: isFavorite(mealId) ?  Icon(Icons.favorite) : Icon(Icons.favorite_border_outlined),
          onPressed: () { 
          setToogleFavorite(mealId);
         },),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                child: Image.network(filteredMeal.imageUrl, fit: BoxFit.cover),
                width: double.infinity,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              _buildIngredientsCard(filteredMeal),
              SizedBox(height: 16),
              _buildStepCard(filteredMeal)
            ],
          ),
        ));
  }

  _buildIngredientsCard(Meal meal) {
    return   Container(
                height: 150.0,
                width: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                child: ListView.builder(
                  itemBuilder: (context, index) => Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(meal.ingredients[index]),
                    ),
                  ),
                  itemCount: meal.ingredients.length,
                ),
              );
  }

  _buildStepCard(Meal meal) {
    return Container(
      height: 150.0,
      width: 300.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            child: Text("# ${index + 1}"),
          ),
          title:  Text(meal.steps[index]),
        ),
        itemCount: meal.steps.length,
      ),
    );
  }
}
