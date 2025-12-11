import 'dart:io';

class Morpion {

  int scoreX = 0;
  int scoreO = 0;
 
  late List<String> grille;
  String joueurActuel = 'X';
  bool partieFinie = false;
  
  // Constructeur : initialise le jeu au moment de la création de l'objet
  Morpion() {
    initialiserJeu();
  }

  // Méthode pour configurer une nouvelle partie
  void initialiserJeu() {
    // Initialisation de la grille avec les numéros 1 à 9
    grille = List.generate(9, (i) => (i + 1).toString());
    joueurActuel = 'X';
    partieFinie = false;
    print(' Nouvelle partie de Morpion ! Joueur X commence.');
    print('SCORE ACTUEL: X=$scoreX | O=$scoreO'); // Affichage du score
  }

  // --- 1. Affichage de la grille ---
  void afficherGrille() {
    print('\n--------------------------');
    print(' ${grille[0]} | ${grille[1]} | ${grille[2]} ');
    print('---|---|---');
    print(' ${grille[3]} | ${grille[4]} | ${grille[5]} ');
    print('---|---|---');
    print(' ${grille[6]} | ${grille[7]} | ${grille[8]} ');
    print('--------------------------\n');
  }

  //  2. Jouer un coup (méthode interne) ---
  bool jouerCoup(int index) {
    int position = index + 1;

    // Validation : Case déjà prise?
    if (grille[index] != position.toString()) {
      print('Cette case est déjà occupée. Réessayez.');
      return false;
    }

    // Le coup est valide, mise à jour de l'état (encapsulation)
    grille[index] = joueurActuel;
    return true;
  }

  // 3. Vérification de la victoire (méthode interne) ---
  bool _verifierVictoire() {
    // Le joueur est implicite (c'est le joueur actuel)
    String joueur = joueurActuel; 
    
    // Combinaisons gagnantes
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

  // 4. Vérification du match nul (méthode interne) ---
  bool _verifierNul() {
    return !grille.any((caseId) => int.tryParse(caseId) != null);
  }

  // Mise à jour du score
  void mettreAJourScore() {
    if (joueurActuel == 'X') {
      scoreX++;
    } else {
      scoreO++;
    }
  }

  // --- 5. Méthode principale qui gère le déroulement du jeu ---
  void jouer() {
    while (!partieFinie) {
      afficherGrille();
      print('Joueur $joueurActuel, entrez le numéro de la case où jouer :');

      var input = stdin.readLineSync();
      int? position;

      // Gestion des erreurs de saisie
      try {
        position = int.parse(input!);
      } catch (e) {
        print('Erreur de saisie. Veuillez entrer un nombre valide (1-9).');
        continue;
      }
      
      // Validation de la position (1-9) vers l'index (0-8)
      if (position! < 1 || position > 9) {
          print('Position hors limites. Choisissez entre 1 et 9.');
          continue;
      }
      
      int index = position - 1;

      // Exécuter le coup et gérer le résultat
      if (jouerCoup(index)) {
        
        if (_verifierVictoire()) {
          afficherGrille();
          mettreAJourScore(); // Appel de la nouvelle méthode
          print('🌟 FÉLICITATIONS ! Le Joueur $joueurActuel a gagné !');
          partieFinie = true;
        } else if (_verifierNul()) {
          afficherGrille();
          print('🤝 Match NUL ! La grille est pleine.');
          partieFinie = true;
        } else {
          // Changer de joueur
          joueurActuel = (joueurActuel == 'X') ? 'O' : 'X';
        }
      } 
    }
    
    // Demander aux joueurs s'ils veulent rejouer
      print('\n--- Fin de la manche ---');
      print('Score actuel : X=$scoreX | O=$scoreO');
      print('Voulez-vous rejouer ? (O/N) :');
      var reponse = stdin.readLineSync()?.toLowerCase();

      if (reponse == 'o') {
        initialiserJeu(); // Relance une nouvelle manche
      } else {
        print('\nAu revoir ! Score final : X=$scoreX | O=$scoreO');
      }

  }
}

// ==========================================================
// FONCTION MAIN : Point d'entrée de l'application
// ==========================================================
void main() {
  // 1. Création de l'instance de la classe Morpion (l'objet)
  Morpion jeu = Morpion();
  
  // 2. Lancement du jeu via la méthode de l'objet
  jeu.jouer();
}