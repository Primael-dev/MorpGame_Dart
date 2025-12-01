import 'dart:io';
import 'functions/player.dart';
import 'functions/game_logic.dart';

class Game {
  late GameLogic _gameLogic;
  late Player _player1;
  late Player _player2;

  Game() {
    _player1 = Player('Joueur 1', 'X');
    _player2 = Player('Joueur 2', 'O');
    _gameLogic = GameLogic(_player1, _player2);
  }

  void displayWelcome() {
    clearScreen();
    print('═' * 40);
    print('       BIENVENUE AU JEU MORPION!');
    print('═' * 40);
    print('');
  }

  void displayMenu() {
    print('1. Jouer');
    print('2. Voir les règles');
    print('3. Voir les scores');
    print('4. Quitter');
    print('');
    stdout.write('Choisissez une option: ');
  }

  void displayRules() {
    clearScreen();
    print('═' * 40);
    print('            RÈGLES DU JEU');
    print('═' * 40);
    print('');
    print('- Le plateau est une grille 3x3');
    print('- Joueur 1 joue avec X, Joueur 2 avec O');
    print('- Entrez les coordonnées: ligne,colonne (ex: 0,1)');
    print('- Alignez 3 symboles pour gagner!');
    print('');
    stdout.write('Appuyez sur Entrée pour continuer...');
    stdin.readLineSync();
  }

  void displayScores() {
    clearScreen();
    print('═' * 40);
    print('            SCORES');
    print('═' * 40);
    print('');
    print(_player1);
    print(_player2);
    print('');
    stdout.write('Appuyez sur Entrée pour continuer...');
    stdin.readLineSync();
  }

  void playGame() {
    bool running = true;
    while (running) {
      displayWelcome();
      displayMenu();
      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          playRound();
          break;
        case '2':
          displayRules();
          break;
        case '3':
          displayScores();
          break;
        case '4':
          print('Merci d\'avoir joué!');
          running = false;
          break;
        default:
          print('Option invalide!');
          sleep(Duration(seconds: 1));
      }
    }
  }

  void playRound() {
    _gameLogic.startNewGame();
    clearScreen();

    while (!_gameLogic.isGameOver()) {
      _gameLogic.getBoard().displayBoard();
      print('Tour de ${_gameLogic.getCurrentPlayer().getName()} (${_gameLogic.getCurrentPlayer().getSymbol()})');

      List<int>? coords = getUserInput();
      if (coords == null) {
        print('Entrée invalide! Format: ligne,colonne (ex: 0,1)');
        sleep(Duration(seconds: 1));
        clearScreen();
        continue;
      }

      if (!_gameLogic.playTurn(coords[0], coords[1])) {
        print('Coup invalide! Veuillez Réessayez.');
        sleep(Duration(seconds: 1));
        clearScreen();
        continue;
      }

      clearScreen();
    }

    _gameLogic.getBoard().displayBoard();
    displayResult();

    if (askReplay()) {
      playRound();
    }
  }

  List<int>? getUserInput() {
    stdout.write('Entrez votre coup (ligne,colonne): ');
    String? input = stdin.readLineSync();
    if (input == null) return null;
    return parseCoordinates(input);
  }

  List<int>? parseCoordinates(String input) {
    try {
      List<String> parts = input.split(',');
      if (parts.length != 2) return null;
      int row = int.parse(parts[0].trim());
      int col = int.parse(parts[1].trim());
      if (row < 0 || row > 2 || col < 0 || col > 2) return null;
      return [row, col];
    } catch (e) {
      return null;
    }
  }

  bool askReplay() {
    stdout.write('Rejouer? (o/n): ');
    String? response = stdin.readLineSync();
    return response?.toLowerCase() == 'o';
  }

  void displayResult() {
    printSeparator();
    print(_gameLogic.getGameStatus());
    printSeparator();
  }

  void clearScreen() {
    print('\n' * 50);
  }

  void printSeparator() {
    print('═' * 40);
  }
}

void main() {
  Game game = Game();
  game.playGame();
}