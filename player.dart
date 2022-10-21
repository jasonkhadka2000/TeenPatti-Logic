import 'cards.dart';

class Player {
  late final int indexId;
  late final int priority;
  late List<Card> cards;
  late final int setOfCardValue;

  Player(int indexId, List<Card> cards, int priority, int setOfCardValue) {
    this.indexId = indexId;
    this.cards = cards;
    this.priority = priority;
    this.setOfCardValue = setOfCardValue;
  }
}
