// Définition de la classe Board pour gérer le plateau de jeu
class Board {
  late List<List<String>> _grid;

  Board() {
    _grid = List.generate(3, (_) => List.filled(3, ' '));
  }

  // Getter pour accéder à la grille
  List<List<String>> get grid => _grid;

  // Afficher le plateau
  void display() {
    print('\n');
    for (int i = 0; i < 3; i++) {
      print(' ${_grid[i][0]} | ${_grid[i][1]} | ${_grid[i][2]} ');
      if (i < 2) print('---|---|---');
    }
    print('\nPositions: 1 2 3');
    print('           4 5 6');
    print('           7 8 9');
  }

  // Placer un symbole sur le plateau
  void setCell(int row, int col, String player) {
    _grid[row][col] = player;
  }

  // Vérifier si une case est vide
  bool isCellEmpty(int row, int col) {
    return _grid[row][col] == ' ';
  }

  // Vérifier si le plateau est plein
  bool isFull() {
    for (var row in _grid) {
      if (row.contains(' ')) return false;
    }
    return true;
  }

  // Réinitialiser le plateau
  void reset() {
    _grid = List.generate(3, (_) => List.filled(3, ' '));
  }
}