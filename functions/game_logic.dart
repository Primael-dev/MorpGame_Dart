//importation de la classe Board
import 'board.dart';

// Définition de la classe GameLogic pour gérer la logique du jeu
class GameLogic {
  final Board _board;

  GameLogic(this._board);

  // Vérifier si un mouvement est valide
  bool isValidMove(int position) {
    if (position < 1 || position > 9) return false;
    
    final row = (position - 1) ~/ 3;
    final col = (position - 1) % 3;
    
    return _board.isCellEmpty(row, col);
  }

  // Vérifier si un joueur a gagné
  bool checkWinner(String player) {
    final grid = _board.grid;

    // Vérifier les lignes
    for (int i = 0; i < 3; i++) {
      if (grid[i][0] == player && 
          grid[i][1] == player && 
          grid[i][2] == player) {
        return true;
      }
    }

    // Vérifier les colonnes
    for (int i = 0; i < 3; i++) {
      if (grid[0][i] == player && 
          grid[1][i] == player && 
          grid[2][i] == player) {
        return true;
      }
    }

    // Vérifier les diagonales
    if (grid[0][0] == player && 
        grid[1][1] == player && 
        grid[2][2] == player) {
      return true;
    }

    if (grid[0][2] == player && 
        grid[1][1] == player && 
        grid[2][0] == player) {
      return true;
    }

    return false;
  }

  // Vérifier si le plateau est plein
  bool isBoardFull() {
    return _board.isFull();
  }
}