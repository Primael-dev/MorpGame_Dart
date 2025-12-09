# Jeu de Morpion en Dart

Un jeu de Morpion (Tic-Tac-Toe) simple développé en Dart avec une architecture orientée objet.

## Description

Ce projet est une implémentation console d'un jeu de Morpion pour deux joueurs. Il utilise les principes de la programmation orientée objet (POO) pour une architecture claire et maintenable.

## Structure du projet

```
.
├── main.dart                 # Point d'entrée du programme
├── morpion_game.dart        # Classe principale du jeu
├── README.md                # Documentation
├── structure.txt            # Architecture du projet
└── functions/
    ├── board.dart           # Gestion du plateau de jeu
    ├── game_logic.dart      # Logique du jeu
    └── Functions.md         # Documentation des fonctions
```

## Installation

### Prérequis

- Dart SDK (version 2.12 ou supérieure)

### Étapes

1. Cloner ou télécharger le projet
2. Vérifier que Dart est installé :
   ```bash
   dart --version
   ```

## Utilisation

### Lancer le jeu

```bash
dart main.dart
```

### Comment jouer

1. Le jeu démarre automatiquement avec le joueur X
2. Entrez un nombre de 1 à 9 pour placer votre symbole
3. Les positions correspondent à :
   ```
   1 | 2 | 3
   ---------
   4 | 5 | 6
   ---------
   7 | 8 | 9
   ```
4. Les joueurs alternent jusqu'à ce qu'il y ait un gagnant ou un match nul

## Architecture

### Classes principales

**MorpionGame** (morpion_game.dart)
- Gère les tours des joueurs
- Contrôle l'état de la partie
- Coordonne Board et GameLogic

**Board** (functions/board.dart)
- Gère le plateau de jeu (grille 3x3)
- Méthodes : display(), setCell(), isCellEmpty(), isFull(), reset()

**GameLogic** (functions/game_logic.dart)
- Contient la logique métier du jeu
- Méthodes : isValidMove(), checkWinner(), isBoardFull()

### Principes POO appliqués

- Encapsulation : Attributs privés avec underscore
- Séparation des responsabilités : Une classe = une fonction
- Composition : MorpionGame compose Board et GameLogic
- Abstraction : Interface simple et claire

## Règles du jeu

1. Le plateau est une grille de 3x3 cases
2. Deux joueurs s'affrontent : X et O
3. Le joueur X commence toujours
4. Les joueurs placent leur symbole à tour de rôle
5. Victoire : Aligner 3 symboles identiques (horizontal, vertical ou diagonal)
6. Match nul : Plateau rempli sans gagnant

## Exemples

### Partie gagnante

```
Tour du joueur X
Entrez la position (1-9): 5

 X |   |  
---|---|---
   | X |  
---|---|---
   |   | X

Joueur X gagne!
```

### Match nul

```
 X | O | X
---|---|---
 O | O | X
---|---|---
 X | X | O

Match nul!
```

## Améliorations possibles

- Ajouter un mode IA (joueur vs ordinateur)
- Implémenter un système de score
- Créer une interface graphique (Flutter)
- Ajouter la sauvegarde des parties
- Permettre de rejouer sans relancer le programme
- Implémenter différents niveaux de difficulté

## Auteur

Projet créé dans un cadre d'apprentissage de Dart et de la POO.

## Licence

Projet libre d'utilisation à des fins éducatives.