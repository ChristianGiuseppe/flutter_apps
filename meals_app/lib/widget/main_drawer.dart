import 'package:flutter/material.dart';
import 'package:meals_app/journeys/settings_screen.dart';
import 'package:meals_app/journeys/tabs_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120.0,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTitle('Meals', Icons.restaurant, (){
            Navigator.of(context).pushReplacementNamed(TabScreen.routeNamed);
          }),
          buildListTitle('Filters', Icons.filter, (){
            Navigator.of(context).pushReplacementNamed(Settings.routeName);
          })
        ],
      ),
    );
  }

  Widget buildListTitle(String title, IconData icon, VoidCallback onTap){
    return  ListTile(
            leading: Icon(
              icon,
              size: 26.0,
            ),
            title: Text(title, style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
            ),
            onTap: onTap, 
          );
  }
}
