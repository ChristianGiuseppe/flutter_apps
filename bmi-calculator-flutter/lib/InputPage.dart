import 'package:bmi_calculator/CardReuse.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                CardReuse(colour: Color(0xFF0A0E21)),
                CardReuse(colour: Color(0xFF0A0E21)),
              ],
            ),
          ),
          CardReuse(),
          Expanded(
            child: Row(
              children: [
                CardReuse(colour: Color(0xFF0A0E21)),
                CardReuse(colour: Color(0xFF0A0E21)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
