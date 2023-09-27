import 'package:flutter/material.dart';

class CardReuse extends StatelessWidget {
  const CardReuse({super.key, this.colour = const Color(0xFF1D1E33)});

  final Color? colour;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: colour, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
