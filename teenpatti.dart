import 'cards.dart';
import 'core_game_logic.dart';
import 'initialise.dart';
import 'player.dart';

void printPlayers(List<Player> players) {
  for (var player in players) {
    print(".......................................");
    print("Player id: " + player.indexId.toString());
    for (var card in player.cards) {
      print((card.value).toString() + "_of_" + card.symbol);
    }
    print("THE priority of above set is: " + player.priority.toString());
    print(".......................................");
  }
}

void main() {
  List<Card> deckOfCards = initialiseDeck();
  int totalPlayers = 13;
  List<Player> players = distributeCards(deckOfCards, totalPlayers);

  List<Player> finalPlayers = finalistPlayers(players);

  List<Player> winnerPlayers = evaluateWinner(finalPlayers);

  print("the initial player with their cards");
  printPlayers(players);
  print(".......................................");
  print("the winner player with their cards");
  printPlayers(winnerPlayers);
}
