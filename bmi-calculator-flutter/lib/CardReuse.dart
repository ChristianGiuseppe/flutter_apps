import 'package:flutter/material.dart';

class CardReuse extends StatelessWidget {
  CardReuse({@required this.colour});

  final Color colour;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(color: colour, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}