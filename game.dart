// game.dart - Classe principale du jeu
import 'dart:io';
import 'functions/board.dart';
import 'functions/game_logic.dart';

/// Classe principale qui gère le déroulement d'une partie de morpion
class Jeu {
  late Plateau _plateau;
  late LogiqueJeu _logique;
  String _joueurActuel = 'X';
  bool _partieEnCours = true;
  
  /// Constructeur qui initialise le plateau et la logique du jeu
  Jeu() {
    _plateau = Plateau();
    _logique = LogiqueJeu(_plateau);
  }
  
  /// Démarre une nouvelle partie
  void demarrer() {
    print('Début de la partie! Le joueur X commence.\n');
    _plateau.afficher();
    
    // Boucle principale du jeu
    while (_partieEnCours) {
      _tourDeJeu();
    }
  }
  
  /// Gère un tour de jeu complet pour un joueur
  void _tourDeJeu() {
    print('\n┌─────────────────────────────┐');
    print('│ Tour du joueur $_joueurActuel           │');
    print('└─────────────────────────────┘');
    print('Entrez le numéro de la case (1-9):');
    
    // Récupère et valide l'entrée du joueur
    String? entree = stdin.readLineSync();
    
    if (entree == null || entree.isEmpty) {
      print(' Entrée invalide! Veuillez entrer un numéro.');
      return;
    }
    
    // Convertit l'entrée en numéro
    int? position = int.tryParse(entree);
    
    if (position == null || position < 1 || position > 9) {
      print('Veuillez entrer un numéro entre 1 et 9.');
      return;
    }
    
    // Tente de placer le symbole sur le plateau
    if (_plateau.placerSymbole(position - 1, _joueurActuel)) {
      _plateau.afficher();
      
      // Vérifie si le joueur a gagné
      if (_logique.verifierVictoire(_joueurActuel)) {
        print('\n ════════════════════════════ ');
        print('   LE JOUEUR $_joueurActuel A GAGNÉ!');
        print(' ════════════════════════════ ');
        _partieEnCours = false;
        return;
      }
      
      // Vérifie si c'est un match nul
      if (_logique.verifierMatchNul()) {
        print('\n ════════════════════════════ ');
        print('      MATCH NUL!');
        print(' ════════════════════════════ ');
        _partieEnCours = false;
        return;
      }
      
      // Change de joueur
      _changerJoueur();
    } else {
      print('❌ Cette case est déjà occupée! Choisissez-en une autre.');
    }
  }
  
  /// Alterne entre les joueurs X et O
  void _changerJoueur() {
    _joueurActuel = (_joueurActuel == 'X') ? 'O' : 'X';
  }
}