import 'dart:io';

// Classe représentant un joueur
class Joueur {
  final String nom;
  final String symbole;

  Joueur(this.nom, this.symbole);
}

// Classe représentant une case du plateau
class Case {
  String? contenu;

  Case() : contenu = null;

  bool estVide() => contenu == null;

  void placer(String symbole) {
    if (estVide()) {
      contenu = symbole;
    }
  }

  void vider() {
    contenu = null;
  }
}

// Classe représentant le plateau de jeu
class Plateau {
  late List<List<Case>> grille;

  Plateau() {
    grille = List.generate(3, (_) => List.generate(3, (_) => Case()));
  }

  void afficher() {
    print('\n╔═════════════════════╗');
    print('║  TIC-TAC-TOE (9x)  ║');
    print('╚═════════════════════╝\n');
    
    // Affichage du numérotage des touches
    print('  Touches : 1-9');
    print('  ┌───┬───┬───┐');
    print('  │ 1 │ 2 │ 3 │');
    print('  ├───┼───┼───┤');
    print('  │ 4 │ 5 │ 6 │');
    print('  ├───┼───┼───┤');
    print('  │ 7 │ 8 │ 9 │');
    print('  └───┴───┴───┘\n');
    
    // Affichage du plateau actuel
    print('  Plateau :');
    print('  ┌───┬───┬───┐');
    for (int i = 0; i < 3; i++) {
      stdout.write('  │');
      for (int j = 0; j < 3; j++) {
        String contenu = grille[i][j].contenu ?? ' ';
        stdout.write(' $contenu │');
      }
      print('');
      if (i < 2) {
        print('  ├───┼───┼───┤');
      }
    }
    print('  └───┴───┴───┘\n');
  }

  bool placerSymbole(int position, String symbole) {
    // Convertir position (1-9) en coordonnées (ligne, colonne)
    int ligne = (position - 1) ~/ 3;
    int colonne = (position - 1) % 3;
    
    if (position >= 1 && position <= 9 && grille[ligne][colonne].estVide()) {
      grille[ligne][colonne].placer(symbole);
      return true;
    }
    return false;
  }

  bool estPlein() {
    for (var ligne in grille) {
      for (var c in ligne) {
        if (c.estVide()) return false;
      }
    }
    return true;
  }

  void reinitialiser() {
    for (var ligne in grille) {
      for (var c in ligne) {
        c.vider();
      }
    }
  }
}

// Classe pour vérifier les conditions de victoire
class VerificateurVictoire {
  bool verifier(Plateau plateau, String symbole) {
    return _verifierLignes(plateau, symbole) ||
        _verifierColonnes(plateau, symbole) ||
        _verifierDiagonales(plateau, symbole);
  }

  bool _verifierLignes(Plateau plateau, String symbole) {
    for (int i = 0; i < 3; i++) {
      if (plateau.grille[i].every((c) => c.contenu == symbole)) {
        return true;
      }
    }
    return false;
  }

  bool _verifierColonnes(Plateau plateau, String symbole) {
    for (int j = 0; j < 3; j++) {
      if (plateau.grille.every((ligne) => ligne[j].contenu == symbole)) {
        return true;
      }
    }
    return false;
  }

  bool _verifierDiagonales(Plateau plateau, String symbole) {
    bool diag1 = true, diag2 = true;
    for (int i = 0; i < 3; i++) {
      if (plateau.grille[i][i].contenu != symbole) diag1 = false;
      if (plateau.grille[i][2 - i].contenu != symbole) diag2 = false;
    }
    return diag1 || diag2;
  }
}

// Classe principale du jeu
class JeuMorpion {
  late Plateau plateau;
  late Joueur joueur1;
  late Joueur joueur2;
  late Joueur joueurActuel;
  late VerificateurVictoire verificateur;
  bool jeuTermine = false;

  JeuMorpion(String nomJoueur1, String nomJoueur2) {
    plateau = Plateau();
    joueur1 = Joueur(nomJoueur1, 'X');
    joueur2 = Joueur(nomJoueur2, 'O');
    joueurActuel = joueur1;
    verificateur = VerificateurVictoire();
  }

  void demarrer() {
    print('\n╔════════════════════════════════╗');
    print('║    🎮 JEU DE MORPION 🎮       ║');
    print('╚════════════════════════════════╝\n');
    print('${joueur1.nom} joue avec [X]');
    print('${joueur2.nom} joue avec [O]\n');

    while (!jeuTermine) {
      plateau.afficher();
      _demanderCoup();
    }

    _proposerNouvellePartie();
  }

  void _demanderCoup() {
    print('┌─────────────────────────────────┐');
    print('│ Tour de ${joueurActuel.nom} (${joueurActuel.symbole})');
    print('└─────────────────────────────────┘');

    int? position;

    while (position == null) {
      stdout.write('Choisissez une case (1-9) ou Q pour quitter: ');
      String? input = stdin.readLineSync();
      
      if (input != null) {
        input = input.trim().toUpperCase();
        
        if (input == 'Q' || input == 'QUIT') {
          print('\n👋 Merci d\'avoir joué ! À bientôt !\n');
          exit(0);
        }
        
        position = int.tryParse(input);
        
        if (position == null || position < 1 || position > 9) {
          print('❌ Entrez un chiffre entre 1 et 9 !');
          position = null;
        } else if (!_effectuerCoup(position)) {
          print('❌ Cette case est déjà occupée ! Choisissez-en une autre.\n');
          position = null;
        }
      }
    }
  }

  bool _effectuerCoup(int position) {
    if (plateau.placerSymbole(position, joueurActuel.symbole)) {
      if (verificateur.verifier(plateau, joueurActuel.symbole)) {
        plateau.afficher();
        print('╔════════════════════════════════╗');
        print('║  🎉 ${joueurActuel.nom} a gagné ! 🎉    ║');
        print('╚════════════════════════════════╝\n');
        jeuTermine = true;
        return true;
      }

      if (plateau.estPlein()) {
        plateau.afficher();
        print('╔════════════════════════════════╗');
        print('║  🤝 Match nul ! Égalité ! 🤝   ║');
        print('╚════════════════════════════════╝\n');
        jeuTermine = true;
        return true;
      }

      _changerJoueur();
      return true;
    }
    return false;
  }

  void _changerJoueur() {
    joueurActuel = (joueurActuel == joueur1) ? joueur2 : joueur1;
  }

  void _proposerNouvellePartie() {
    stdout.write('Voulez-vous jouer une nouvelle partie ? (O/N): ');
    String? reponse = stdin.readLineSync();
    
    if (reponse != null) {
      reponse = reponse.trim().toUpperCase();
      
      if (reponse == 'O' || reponse == 'OUI') {
        _nouvellePartie();
        demarrer();
      } else {
        print('\n👋 Merci d\'avoir joué ! À bientôt !\n');
      }
    }
  }

  void _nouvellePartie() {
    plateau.reinitialiser();
    joueurActuel = joueur1;
    jeuTermine = false;
  }
}

// Fonction principale
void main() {
  print('\n╔════════════════════════════════════════╗');
  print('║                                        ║');
  print('║     Bienvenue au Jeu de Morpion !     ║');
  print('║                                        ║');
  print('╚════════════════════════════════════════╝\n');
  print('Règles du jeu :');
  print('- Utilisez les touches 1-9 pour placer votre symbole');
  print('- Le premier à aligner 3 symboles gagne');
  print('- Tapez Q pour quitter à tout moment\n');
  
  stdout.write('Nom du joueur 1 (X): ');
  String? nom1 = stdin.readLineSync();
  if (nom1 == null || nom1.trim().isEmpty) nom1 = 'Joueur 1';
  
  stdout.write('Nom du joueur 2 (O): ');
  String? nom2 = stdin.readLineSync();
  if (nom2 == null || nom2.trim().isEmpty) nom2 = 'Joueur 2';
  
  var jeu = JeuMorpion(nom1.trim(), nom2.trim());
  jeu.demarrer();
}