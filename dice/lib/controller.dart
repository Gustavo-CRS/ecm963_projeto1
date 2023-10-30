import 'dart:io';

import 'package:dice/dice.dart';

class Controller {
  int sumDices(List<Dice> dados) {
    int soma = 0;
    for (Dice dado in dados) {
      soma += dado.face;
    }
    return soma;
  }

  List<Dice> rollDices(List<Dice> dices) {
    for (Dice dado in dices) {
      dado.throwDice();
    }
    return dices;
  }

  List<Dice> createDices(int number) {
    List<Dice> dices = [];
    for (int i = 0; i < number; i++) {
      dices.add(Dice());
    }
    return dices;
  }

  int inputRoundsToPlay() {
    int rounds = 0;
    bool roundsIsValid = false;

    while (!roundsIsValid) {
      print("Informe quantas rodadas deseja jogar: ");

      try {
        String input = stdin.readLineSync() ?? "";
        rounds = int.parse(input);
        if (rounds > 0) {
          roundsIsValid = true;
        } else {
          print("O número de rodadas deve ser maior que zero.");
        }
      } catch (e) {
        print("O número de rodadas deve ser um número inteiro.");
        roundsIsValid = false;
      }
    }
    return rounds;
  }

  void showNameGame(String nameGame) {
    const int nameGameFactor = 2;

    final String spacePadding =
        " " * (nameGame.length / nameGameFactor).round();
    final nameGameToShow = "$spacePadding$nameGame$spacePadding".toUpperCase();

    print("=" * nameGame.length * nameGameFactor);
    print(nameGameToShow);
    print("=" * nameGame.length * nameGameFactor);
    print("\n");
  }

  void showDices(List<Dice> dices) {
    List<String> dicesFaces = [];

    for (Dice dado in dices) {
      dicesFaces.add(dado.face.toString());
    }
    print("Dados: ${dicesFaces.join(" - ")}");
    print("Soma ${sumDices(dices)}");
  }

  void cleanConsole(){
    print("\x1B[2J\x1B[0;0H");
  }

  void showPoints(int playerVictories, int computerVictories, int draws) {
    int numberOfCharacters =
        " Você: $playerVictories x $computerVictories CPU ".length;
    int drawPadding =
        ((numberOfCharacters - "Empates: $draws".length) / 2).round();

    print("-" * numberOfCharacters);
    print(" Você: $playerVictories x $computerVictories CPU  ");
    print("${" " * drawPadding}Empates: $draws${" " * drawPadding}");
    print("-" * numberOfCharacters);
  }

  void showFinalPoints(int playerVictories, int computerVictories, int draws) {
    print("=== PLACAR FINAL ===\n");
    showPoints(playerVictories, computerVictories, draws);
    print("\n====================\n");

    if (playerVictories > computerVictories) {
      print("Jogador VENCEU!");
    } else if (playerVictories < computerVictories) {
      print("Computador venceu!");
    } else {
      print("Empate!");
    }
  }

  bool inputUseMagicDice() {
    bool useMagicDice = false;
    bool useMagicDiceIsValid = false;

    while (!useMagicDiceIsValid) {
      print("Você tem um dado mágico! Deseja usa-lo? (s/n): ");
      String input = stdin.readLineSync() ?? "";
      if (input.toLowerCase() == "s") {
        useMagicDice = true;
        useMagicDiceIsValid = true;
        print("Você usou o dado mágico!");
      } else if (input.toLowerCase() == "n") {
        useMagicDice = false;
        useMagicDiceIsValid = true;
        print("Você não usou o dado mágico!");
      } else {
        print("Opção inválida!");
        useMagicDiceIsValid = false;
      }
    }
    print("\n");
    return useMagicDice;
  }
}
