import 'dart:io';
import 'functions/functions.dart';

void main() {
  Morpion jeu = Morpion();
  String joueur = "X";
  bool fini = false;

  print("=== JEU DU MORPION ===");

  while (!fini) {
    jeu.afficherPlateau();

    print("Joueur $joueur, choisissez une case (0 à 8) : ");
    int? choix = int.tryParse(stdin.readLineSync()!);

    if (choix == null) {
      print("Veuillez entrer un nombre valide.");
      continue;
    }

    // Si le coup est accepté
    if (jeu.jouer(choix, joueur)) {
      // Vérifier la victoire
      if (jeu.aGagne(joueur)) {
        jeu.afficherPlateau();
        print("🎉 Joueur $joueur a gagné !");
        fini = true;
      }
      // Vérifier match nul
      else if (jeu.estPlein()) {
        jeu.afficherPlateau();
        print("🤝 Match nul !");
        fini = true;
      }
      // Sinon changer de joueur
      else {
        joueur = (joueur == "X") ? "O" : "X";
      }
    }
  }
}