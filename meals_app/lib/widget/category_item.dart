import 'package:flutter/material.dart';
import 'package:meals_app/journeys/category_meal_screen.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(
      {Key? key, required this.id, required this.title, required this.bgColor});
  final String id;
  final String title;
  final Color bgColor;

  void goToCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealScreen.routeName, arguments: {
      'id': id,
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15.0),
      onTap: () => goToCategory(context),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [bgColor.withOpacity(0.7), bgColor]),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
