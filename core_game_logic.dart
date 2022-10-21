import 'player.dart';

List<Player> finalistPlayers(List<Player> players) {
  List<Player> finalPlayers = [];
  players.sort((a, b) {
    return b.priority.compareTo(a.priority);
  });

  int maxPriority = players[0].priority;

  for (var player in players) {
    if (player.priority == maxPriority) {
      finalPlayers.add(player);
    }
  }
  return finalPlayers;
}

List<Player> evaluateWinner(List<Player> finalPlayers) {
  List<Player> winner = [];

  //if only one max priority then he automatically wins
  if (finalPlayers.length == 1) {
    winner.add(finalPlayers[0]);
  }
  //if the are multiple players with same priority
  else {
    int winnerPriority = finalPlayers[0].priority;
    //joothdetection
    if (winnerPriority == 1) {
      return handleJoothCollision(finalPlayers);
    }

    //everything except jooth
    else {
      finalPlayers.sort((a, b) {
        return b.setOfCardValue.compareTo(a.setOfCardValue);
      });

      //calculating the number of winner
      int maxSetOfValue = finalPlayers[0].setOfCardValue;
      int numberOfWinners = 0;
      for (var player in finalPlayers) {
        print(player.setOfCardValue);
        if (player.setOfCardValue == maxSetOfValue) {
          numberOfWinners = numberOfWinners + 1;
        }
      }

      //if there is only one winner
      if (numberOfWinners == 1) {
        winner.add(finalPlayers[0]);
        return winner;
      } else {
        for (var player in finalPlayers) {
          if (player.setOfCardValue == maxSetOfValue) {
            winner.add(player);
          }
        }
        return winner;
      }
    }
  }

  return winner;
}

List<Player> handleJoothCollision(List<Player> finalPlayers) {
  List<Player> winners = [];
  List<int> joothCards = [];

  print("inside jooth collision");

  for (var player in finalPlayers) {
    if (player.cards[0].value == player.cards[1].value ||
        player.cards[0].value == player.cards[2].value) {
      joothCards.add(player.cards[0].value);
    } else {
      joothCards.add(player.cards[1].value);
    }
  }

  //finding the higher jooth
  int maxJoothCard = 0;
  for (var value in joothCards) {
    if (value >= maxJoothCard) {
      maxJoothCard = value;
    }
  }
  print(maxJoothCard);

  for (var player in finalPlayers) {
    for (var card in player.cards) {
      if (card.value == maxJoothCard) {
        winners.add(player);
        break;
      }
    }
  }

  List<Player> joothCollisionWinner = [];
  //if there is same winner jooth card
  if (winners.length == 2) {
    if (winners[0].setOfCardValue > winners[1].setOfCardValue) {
      joothCollisionWinner.add(winners[0]);
    } else if (winners[0].setOfCardValue < winners[1].setOfCardValue) {
      joothCollisionWinner.add(winners[1]);
    } else {
      joothCollisionWinner.add(winners[0]);
      joothCollisionWinner.add(winners[1]);
    }
    winners = joothCollisionWinner;
  }

  return winners;
}
