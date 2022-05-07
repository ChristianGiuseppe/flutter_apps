import 'package:flutter/material.dart';
import 'package:meals_app/data/meal.dart';
import 'package:meals_app/journeys/categories_screen.dart';
import 'package:meals_app/journeys/favorite_meal_screen.dart';
import 'package:meals_app/widget/main_drawer.dart';

class TabScreen extends StatefulWidget {
  static const String routeNamed = "/";
  TabScreen({Key? key, required this.favorite}) : super(key: key);
  final List<Meal> favorite;
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer:MainDrawer(),
        appBar: AppBar(
          title: Text('MEALS'),
          bottom: TabBar(
            tabs: [
              Tab(icon:Icon(Icons.category),text: 'Categories'),
              Tab(icon:Icon(Icons.favorite),text: 'favorites',)
            ],
          ),
        ),
        body: TabBarView(children: [
          CategoriesScreen(),
          FavoriteMealScreen(favorite: widget.favorite)
        ])
      ),
    );
  }
}
