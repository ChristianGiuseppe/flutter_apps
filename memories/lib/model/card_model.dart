class CardModel {
  bool isFaceUp;
  String value;

  CardModel({this.isFaceUp = false, required this.value});

  void flipCard() {
    isFaceUp = !isFaceUp;
  }
}
