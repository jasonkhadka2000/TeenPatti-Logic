import 'dart:math';

import 'cards.dart';
import 'player.dart';

//this function initialises a deck of cards
List<Card> initialiseDeck() {
  List<Card> deckOfCards = [];
  List<int> numbers = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];
  List<String> symbols = ["clubs", "spades", "hearts", "diamonds"];
  int id = 0;

  for (int number in numbers) {
    for (String symbol in symbols) {
      String imageLocation = number.toString() + "_of_" + symbol;
      deckOfCards.add(Card(id, number, symbol, imageLocation));
      id = id + 1;
    }
  }
  deckOfCards.shuffle();
  return deckOfCards;
}

//run check function
bool isRunCheck(List<Card> cards) {
  List<int> cardsNumbers = [];

  //sorting the cards
  cards.sort((a, b) {
    return b.value.compareTo(a.value);
  });

  for (var eachCard in cards) {
    cardsNumbers.add(eachCard.value);
  }

  //case of Ace Two and Three
  if (cardsNumbers[0] == 14 && cardsNumbers[1] == 3 && cardsNumbers[2] == 2) {
    return true;
  }

  if ((cardsNumbers[0] - cardsNumbers[1]) == 1 &&
      (cardsNumbers[1] - cardsNumbers[2]) == 1) {
    return true;
  } else {
    return false;
  }
}

bool isColourCheck(List<Card> cards) {
  if (cards[0].symbol == cards[1].symbol &&
      cards[2].symbol == cards[1].symbol) {
    return true;
  } else {
    return false;
  }
}

//this function evaluates the priority of a card
int evaluatePriority(List<Card> cards) {
  Map priority = {
    "trial": 5,
    "doublerun": 4,
    "run": 3,
    "colour": 2,
    "jooth": 1,
    "top": 0,
  };

  bool isTrial =
      (cards[0].value == cards[1].value && cards[1].value == cards[2].value);

  bool isDoubleRun = isRunCheck(cards) && isColourCheck(cards);
  bool isRun = isRunCheck(cards);
  bool isColour = isColourCheck(cards);
  bool isJooth =
      (cards[0].value == cards[1].value || cards[1].value == cards[2].value);

  //checking for category
  if (isTrial) {
    return priority["trial"];
  }

  if (isDoubleRun) {
    return priority["doublerun"];
  }

  if (isRun) {
    return priority["run"];
  }

  if (isColour) {
    return priority["colour"];
  }

  if (isJooth) {
    return priority["jooth"];
  }

  return priority["top"];
}

//this function initialises all the players after distributing 3 cards to them
List<Player> distributeCards(List<Card> deckOfCards, int totalPlayers) {
  List<Card> deckCopy = [];
  for (var card in deckOfCards) {
    deckCopy.add(card);
  }

  List<Player> players = [];
  //properties of a player
  List<Card> cards = [];
  int index;
  int priority;

  deckCopy.shuffle();

  for (int i = 0; i < totalPlayers; i++) {
    index = i;
    //distribute 3 cards to each player
    for (int j = 0; j < 3; j++) {
      int randomIndex = Random().nextInt(deckCopy.length);
      Card newCard = deckCopy[randomIndex];
      cards.add(newCard);
      Card delCard = deckCopy.removeAt(randomIndex);
    }

    priority = evaluatePriority(cards);
    players.add(Player(index, cards, priority, setOfCardValueSet(cards)));
    cards = [];
  }
  return players;
}

int setOfCardValueSet(List<Card> cards) {
  String setOfCardValue = "";

  cards.sort((a, b) {
    return b.value.compareTo(a.value);
  });

  //compute set of cards value
  for (var card in cards) {
    if (card.value < 10) {
      setOfCardValue = setOfCardValue + "0" + card.value.toString();
    } else {
      setOfCardValue = setOfCardValue + card.value.toString();
    }
  }

  return int.parse(setOfCardValue);
}
