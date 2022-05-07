import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/data/meal.dart';
import 'package:meals_app/journeys/category_meal_screen.dart';
import 'package:meals_app/journeys/meal_detail_screen.dart';
import 'package:meals_app/journeys/settings_screen.dart';
import 'package:meals_app/journeys/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _meals = DUMMY_MEALS;
  List<Meal> _favorite = [];

  void setToogleFavorite(String idMeal) {
    final existingID = _meals.indexWhere((element) => element.id == idMeal);
    if (existingID >= 0) {
      setState(() {
        _favorite.add(_meals.firstWhere((element) => element.id == idMeal));
      });
    } else {
      setState(() {
        _favorite.removeAt(existingID);
      });
    }
  }

  bool isFavorite(String id) {
    int item = _favorite.indexWhere((element) => element.id == id);
    if (item >= 0) {
      return true;
      setState(() {});
    }
    return false;
  }

  void setFilter(Map<String, bool> filters) {
    setState(() {
      this.filters = filters;
    });
    _meals = DUMMY_MEALS.where((meal) {
      if (filters['gluten']! && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan']! && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        TabScreen.routeNamed: (ctx) => TabScreen(favorite: _favorite),
        CategoryMealScreen.routeName: (ctx) => CategoryMealScreen(_meals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              setToogleFavorite: setToogleFavorite,
              isFavorite: isFavorite,
            ),
        Settings.routeName: (ctx) => Settings(
              filter: filters,
              setFilter: setFilter,
            )
      },
    );
  }
}
