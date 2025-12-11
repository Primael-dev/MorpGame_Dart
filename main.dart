import 'dart:io';
import 'game.dart';

void main() {
  print('╔════════════════════════════╗');
  print('║   BIENVENUE AU MORPION!   ║');
  print('╔════════════════════════════╗\n');
  
  bool rejouer = true;
  
  while (rejouer) {
    
    final jeu = Jeu();
    jeu.demarrer();
    
    print('\nVoulez-vous rejouer? (o/n)');
    String? reponse = stdin.readLineSync()?.toLowerCase();
    rejouer = (reponse == 'o' || reponse == 'oui');
  }
  
  print('\nMerci d\'avoir joué! À bientôt! ');
}