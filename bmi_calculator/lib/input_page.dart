import 'package:bmi_calculator/card_reuse.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  InputPageState createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: const Column(
        children: [
          Expanded(
            child: Row(
              children: [
                CardReuse(colour: Color(0xFF1D1E33)),
                CardReuse(colour: Color(0xFF1D1E33)),
              ],
            ),
          ),
          CardReuse(),
          Expanded(
            child: Row(
              children: [
                CardReuse(colour: Color(0xFF1D1E33)),
                CardReuse(colour: Color(0xFF1D1E33)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
