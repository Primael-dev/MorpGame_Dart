// functions/game_logic.dart - Logique du jeu

import 'board.dart';

/// Classe qui gère toute la logique du jeu de morpion
class LogiqueJeu {
  final Plateau _plateau;
  
  // Toutes les combinaisons gagnantes possibles au morpion
  // Chaque ligne représente 3 positions alignées
  static const List<List<int>> _combinaisonsGagnantes = [
    // Lignes horizontales
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    // Colonnes verticales
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    // Diagonales
    [0, 4, 8],
    [2, 4, 6],
  ];
  
  /// Constructeur qui associe la logique à un plateau
  LogiqueJeu(this._plateau);
  
  /// Vérifie si un joueur a gagné la partie
  /// Retourne true si le joueur a aligné 3 symboles
  bool verifierVictoire(String symbole) {
    List<String> cases = _plateau.cases;
    
    // Parcourt toutes les combinaisons gagnantes
    for (var combinaison in _combinaisonsGagnantes) {
      // Vérifie si les 3 cases de la combinaison contiennent le même symbole
      if (cases[combinaison[0]] == symbole &&
          cases[combinaison[1]] == symbole &&
          cases[combinaison[2]] == symbole) {
        return true;
      }
    }
    
    return false;
  }
  
  /// Vérifie si la partie est un match nul
  /// Un match nul survient quand toutes les cases sont remplies sans gagnant
  bool verifierMatchNul() {
    // Si toutes les cases sont remplies
    return _plateau.nombreCasesVides() == 0;
  }
  
  /// Vérifie si la partie est terminée (victoire ou match nul)
  bool estPartieTerminee(String joueur1, String joueur2) {
    return verifierVictoire(joueur1) || 
           verifierVictoire(joueur2) || 
           verifierMatchNul();
  }
  
  /// Obtient toutes les positions vides disponibles
  /// Utile pour implémenter une IA plus tard
  List<int> obtenirPositionsDisponibles() {
    List<int> positions = [];
    for (int i = 0; i < 9; i++) {
      if (_plateau.estCaseVide(i)) {
        positions.add(i);
      }
    }
    return positions;
  }
}