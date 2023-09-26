import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardGame extends StatefulWidget {
  final String card;
  bool isFlipped = false;
  CardGame({
    super.key,
    required this.card,
  });

  late AnimationController controller;

  void flipFront() {
    if (!isFlipped) {
      controller.forward();
    }
  }

  void flipBack() {
    controller.reverse();
    isFlipped = false;
  }

  @override
  State<CardGame> createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> with TickerProviderStateMixin {
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    widget.controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(widget.controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _buildFlipAnimation(widget.card);
  }

  Widget _buildFlipAnimation(String card) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 136,
      width: 80,
      child: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(2, 1, 0.0015)
            ..rotateY(3.14 *
                _animation
                    .value), // 3.14 = pi radian = 180 degree when animation.value = 1
          child: _animation.value <= 0.5
              ? _buildBackCard()
              : _buildFrontCard(card)),
    );
  }

  Widget _buildFrontCard(String card) {
    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/back_card.png'),
          ),
        ),
        child: Text(
          card,
          style: const TextStyle(fontSize: 48),
        ));
  }

  Widget _buildBackCard() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/front_card.png'),
        ),
      ),
    );
  }
}
