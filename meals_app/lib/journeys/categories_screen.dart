import 'package:flutter/material.dart';
import 'package:meals_app/widget/category_item.dart';
import '../data/dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meal Categories',
          style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: GridView(
          children: DUMMY_CATEGORIES
              .map((e) => CategoryItem(id: e.id, title: e.title, bgColor: e.color))
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0),
        ),
      ),
    );
  }
}
