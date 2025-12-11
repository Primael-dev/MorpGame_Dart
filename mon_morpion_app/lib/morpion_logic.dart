// Définition des états possibles après un coup
enum EtatPartie {
  enCours,
  victoire,
  nul,
}

class Morpion {
  // --- ÉTAT GLOBAL ET PROPRIÉTÉS ---

  int scoreX = 0;
  int scoreO = 0;
  
  // Utilisez une liste de chaînes vides pour la grille Flutter
  late List<String> grille; 
  String joueurActuel = 'X';
  
  Morpion() {
    initialiserJeu();
  }

  // Initialise la grille pour une nouvelle manche
  void initialiserJeu() {
    // Remplissage avec des chaînes vides ('' au lieu de '1', '2', etc. car l'UI Flutter les gère)
    grille = List.filled(9, ''); 
    joueurActuel = 'X';
  }

  // --- LOGIQUE DE JEU ---

  // Tente de jouer un coup. Retourne l'état du jeu après le coup.
  EtatPartie jouerCoup(int index) {
    
    // 1. Validation : Si la case est déjà prise, on ne fait rien.
    if (grille[index] != '') {
      return EtatPartie.enCours; // Le jeu continue, mais le coup est invalide
    }

    // 2. Placement du symbole
    grille[index] = joueurActuel;
    
    // 3. Vérification des conditions de fin
    if (verifierVictoire()) {
      mettreAJourScore();
      return EtatPartie.victoire;
    } else if (verifierNul()) {
      return EtatPartie.nul;
    } else {
      // 4. Changement de joueur
      joueurActuel = (joueurActuel == 'X') ? 'O' : 'X';
      return EtatPartie.enCours;
    }
  }

  // Vérifie la victoire (la logique reste la même)
  bool verifierVictoire() {
    String joueur = joueurActuel; 
    
    List<List<int>> combinaisonsGagnantes = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ];

    for (var combinaison in combinaisonsGagnantes) {
      if (grille[combinaison[0]] == joueur &&
          grille[combinaison[1]] == joueur &&
          grille[combinaison[2]] == joueur) {
        return true;
      }
    }
    return false;
  }

  // Vérifie le match nul (la logique reste la même)
  bool verifierNul() {
    // Si toutes les cases sont différentes de '' (chaîne vide), la grille est pleine
    return !grille.contains('');
  }
  
  // Met à jour le score global
  void mettreAJourScore() {
    if (joueurActuel == 'X') {
      scoreX++;
    } else {
      scoreO++;
    }
  }
}