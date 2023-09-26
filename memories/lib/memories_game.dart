import 'package:flutter/material.dart';
import 'package:memories/card_game.dart';
import 'package:memories/deck.dart';

class MemoriesGame extends StatefulWidget {
  const MemoriesGame({super.key});

  @override
  State<MemoriesGame> createState() => _MemoriesGameState();
}

class _MemoriesGameState extends State<MemoriesGame> {
  final List<String> _deck = Deck().shuffle();
  late List<CardGame> _cards;
  int counterFlippedCards = 0;
  CardGame? value1;
  CardGame? value2;

  @override
  void initState() {
    _cards = [];
    for (var item in _deck) {
      CardGame card = CardGame(
        card: item,
      );
      _cards.add(card);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Image(
                  image: AssetImage('assets/images/memories_title.png')),
              const SizedBox(
                height: 8,
              ),
              for (int i = 0; i < 4; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int j = 0; j < 4; j++)
                      GestureDetector(
                          onTap: () => checkFlip(i * 4 + j),
                          child: _cards[i * 4 + j]),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void checkFlip(int index) async {
    setState(() {
      if (value1 != null && value2 == null) {
        value2 = _cards[index];

        if (value1?.isFlipped == true && value2?.isFlipped == true) {
          return;
        }
        if (value1?.card == value2?.card) {
          counterFlippedCards += 2;
        }

        if (counterFlippedCards == _cards.length) {
          print('End of game');
        }
        _cards[index].flipFront();

        Future<void>.delayed(const Duration(seconds: 1), () {
          if (value1?.card != value2?.card) {
            value1?.flipBack();
            value2?.flipBack();
          }
        });
      } else if (value1 == null) {
        value1 = _cards[index];
        _cards[index].flipFront();
      } else {
        value1 = null;
        value2 = null;
      }
    });
  }
}
