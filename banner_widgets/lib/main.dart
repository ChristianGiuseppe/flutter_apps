import 'package:banner_widgets/banner/badge_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BadgeApp(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Text('Hello World!'),
          ),
        ),
      ),
    );
  }
}
