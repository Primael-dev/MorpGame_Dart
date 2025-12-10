class Plateau {
  // Liste qui stocke les 9 cases du plateau
  final List<String> _cases = List.filled(9, ' ');
  
  /// Getter pour accéder aux cases (lecture seule depuis l'extérieur)
  List<String> get cases => List.unmodifiable(_cases);
  
  /// Affiche le plateau de jeu dans la console avec une mise en forme
  void afficher() {
    print('\n     │     │     ');
    print('  ${_obtenirAffichage(0)}  │  ${_obtenirAffichage(1)}  │  ${_obtenirAffichage(2)}  ');
    print('     │     │     ');
    print('─────┼─────┼─────');
    print('     │     │     ');
    print('  ${_obtenirAffichage(3)}  │  ${_obtenirAffichage(4)}  │  ${_obtenirAffichage(5)}  ');
    print('     │     │     ');
    print('─────┼─────┼─────');
    print('     │     │     ');
    print('  ${_obtenirAffichage(6)}  │  ${_obtenirAffichage(7)}  │  ${_obtenirAffichage(8)}  ');
    print('     │     │     \n');
  }
  
  /// Retourne le contenu d'une case pour l'affichage
  /// Si la case est vide, affiche son numéro (1-9)
  String _obtenirAffichage(int index) {
    if (_cases[index] == ' ') {
      return (index + 1).toString();
    }
    return _cases[index];
  }
  
  /// Tente de placer un symbole (X ou O) à une position donnée
  /// Retourne true si le placement est réussi, false sinon
  bool placerSymbole(int position, String symbole) {
    // Vérifie que la position est valide et la case est vide
    if (position >= 0 && position < 9 && _cases[position] == ' ') {
      _cases[position] = symbole;
      return true;
    }
    return false;
  }
  
  /// Vérifie si une case est vide
  bool estCaseVide(int position) {
    return position >= 0 && position < 9 && _cases[position] == ' ';
  }
  
  /// Réinitialise le plateau (vide toutes les cases)
  void reinitialiser() {
    for (int i = 0; i < 9; i++) {
      _cases[i] = ' ';
    }
  }
  
  /// Compte le nombre de cases vides restantes
  int nombreCasesVides() {
    return _cases.where((case_) => case_ == ' ').length;
  }
}