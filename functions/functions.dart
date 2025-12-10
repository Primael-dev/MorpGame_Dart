class Morpion {
  // Le plateau du jeu : 9 cases
  List<String> board = List.filled(9, ' ');

  // Affiche le plateau dans la console
  void afficherPlateau() {
    print("""
 ${board[0]} | ${board[1]} | ${board[2]}
---+---+---
 ${board[3]} | ${board[4]} | ${board[5]}
---+---+---
 ${board[6]} | ${board[7]} | ${board[8]}
    """);
  }

  // Jouer un coup dans une case
  bool jouer(int position, String symbole) {
    if (position < 0 || position > 8) {
      print("Cette position n'existe pas !");
      return false;
    }
    if (board[position] != ' ') {
      print("Case déjà occupée !");
      return false;
    }

    board[position] = symbole;
    return true;
  }

  // Vérifie si un joueur a gagné
  bool aGagne(String s) {
    List<List<int>> lignes = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var l in lignes) {
      if (board[l[0]] == s &&
          board[l[1]] == s &&
          board[l[2]] == s) {
        return true;
      }
    }

    return false;
  }

  // Vérifie si toutes les cases sont remplies
  bool estPlein() {
    return !board.contains(' ');
  }
}