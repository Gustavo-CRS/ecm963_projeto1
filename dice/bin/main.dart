import 'dart:math';

import 'package:dice/controller.dart';
import 'package:dice/dice.dart';

main() async {
  final Controller controller = Controller();
  const String nameGame = " Jogo dos Dados";

  controller.cleanConsole();
  controller.showNameGame(nameGame);

  bool hadUsedMagicDice = false;
  bool magicDiceResult = false;

  int rounds = controller.inputRoundsToPlay();

  int playerVictories = 0;
  int computerVictories = 0;
  int draws = 0;

  for(int i = 1; i <= rounds; i++){

    bool useMagicDice = false;
    
    controller.cleanConsole();

    controller.showNameGame(nameGame);
    controller.showPoints(playerVictories, computerVictories, draws);

    print("\n${"-" * 3} Rodada $i de $rounds ${"-" * 3}\n");

    if(!hadUsedMagicDice){
      useMagicDice = controller.inputUseMagicDice();
      
      if(useMagicDice){
        print("Lançando dado mágico...");
        await Future.delayed(Duration(seconds: 2));
        magicDiceResult = Random().nextBool();
        
        if(magicDiceResult){
          print("SEUS DADOS SERÃO MULTIPLICADOS POR 2!\n");
        }
        else{
          print("SEUS DADOS SERÃO DIVIDIDOS POR 2!\n");
        }
      } 
    }

    List<Dice> playersDices = controller.createDices(3);
    List<Dice> computerDices = controller.createDices(3);

    print("Lançando dados do jogador...");
    await Future.delayed(Duration(seconds: 2));
    playersDices = controller.rollDices(playersDices);
    controller.showDices(playersDices);

    if(useMagicDice){
      hadUsedMagicDice = true;
      if(magicDiceResult){
        print("Multiplicando seus dados por 2...");
        for(Dice dado in playersDices){
          dado.face *= 2;
        }
      }
      else{
        print("Dividindo seus dados por 2...");
        for(Dice dado in playersDices){
          dado.face = (dado.face / 2).round();
        }
      }
      controller.showDices(playersDices);
    }
    
    print("\n");

    print("Lançando dados do computador...");
    await Future.delayed(Duration(seconds: 2));
    computerDices = controller.rollDices(computerDices);
    controller.showDices(computerDices);
    print("\n");

    int sumPlayersDices =  controller.sumDices(playersDices);
    int sumComputerDices = controller.sumDices(computerDices);

    if(sumPlayersDices > sumComputerDices){
      print("Jogador VENCEU!");
      playerVictories++;
    }
    else if(sumPlayersDices < sumComputerDices){
      print("Computador venceu!");
      computerVictories++;
    }
    else{
      print("Empate!");
      draws++;
    }

    print("\nRecolhendo os dados...\n");
    await Future.delayed(Duration(seconds: 2));
  }

  controller.cleanConsole();
  controller.showNameGame(nameGame);
  controller.showFinalPoints(playerVictories, computerVictories, draws);
}














