//importation des bibliothèques nécessaires
import 'dart:io';
import 'functions/board.dart';
import 'functions/game_logic.dart';

// Définition de la classe MorpionGame pour gérer le jeu
class MorpionGame {
  late Board _board;
  late GameLogic _logic;
  String _currentPlayer = 'X';
  bool _gameOver = false;

  MorpionGame() {
    _board = Board();
    _logic = GameLogic(_board);
  }

// Démarrer le jeu
  void start() {
    print('Joueur X commence!\n');
    
    while (!_gameOver) {
      _board.display();
      _playTurn();
      _checkGameStatus();
      
      if (!_gameOver) {
        _switchPlayer();
      }
    }
  }

// Gérer le tour d'un joueur
  void _playTurn() {
    print('\nTour du joueur $_currentPlayer');
    print('Entrez la position (1-9):');
    
    // Boucle jusqu'à ce qu'un mouvement valide soit fait
    while (true) {
      try {
        final input = stdin.readLineSync();
        if (input == null) continue;
        
        final position = int.parse(input);
        // Vérifier si le mouvement est valide
        if (_logic.isValidMove(position)) {
          final row = (position - 1) ~/ 3;
          final col = (position - 1) % 3;
          _board.setCell(row, col, _currentPlayer);
          break;
        } else {
          print('Position invalide ou déjà occupée. Réessayez:');
        }
      } catch (e) {
        print('Entrée invalide. Entrez un nombre entre 1 et 9:');
      }
    }
  }

// Vérifier l'état du jeu après un tour
  void _checkGameStatus() {
    if (_logic.checkWinner(_currentPlayer)) {
      _board.display();
      print('\n Joueur $_currentPlayer gagne! ');
      _gameOver = true;
    } else if (_logic.isBoardFull()) {
      _board.display();
      print('\n Match nul! ');
      _gameOver = true;
    }
  }

// Changer de joueur
  void _switchPlayer() {
    _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
  }
}