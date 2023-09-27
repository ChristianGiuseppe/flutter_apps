import 'package:flutter/material.dart';
import 'input_page.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: const Color(0xFF1D1E33),
          scaffoldBackgroundColor: const Color(0xFF0A0E21),
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Colors.white))),
      home: const InputPage(),
    );
  }
}
