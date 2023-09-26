class Deck {
  final List<String> _deck = [
    '🐱',
    '🦉',
    '🐾',
    '🦄',
    '🦋',
    '🐛',
    '🐝',
    '🐬',
    '🐱',
    '🦉',
    '🐾',
    '🦄',
    '🦋',
    '🐛',
    '🐝',
    '🐬'
  ];

  List<String> shuffle() {
    List<String> deckToBeShuffle = [];
    deckToBeShuffle.addAll(_deck);
    deckToBeShuffle.shuffle();
    return deckToBeShuffle;
  }
}
