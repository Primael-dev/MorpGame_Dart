#  Jeu de Morpion en Dart

Un jeu de morpion (Tic-Tac-Toe) programmé en Dart de manière modulaire et orientée objet.

##  Structure du Projet

```
├── main.dart                # Point d'entrée du programme
├── game.dart                # Classe principale du jeu
├── README.md                # Documentation
└── functions/
    ├── board.dart           # Gestion du plateau de jeu
    ├── game_logic.dart      # Logique du jeu
```

##  Fonctionnalités

- ✅ Jeu de morpion classique pour 2 joueurs (X et O)
- ✅ Interface console claire et intuitive
- ✅ Validation des entrées utilisateur
- ✅ Détection automatique des victoires
- ✅ Détection des matchs nuls
- ✅ Possibilité de rejouer autant de fois que souhaité
- ✅ Code modulaire et orienté objet

##  Comment Jouer

### Installation

1. Assurez-vous d'avoir Dart installé sur votre machine
2. Téléchargez tous les fichiers du projet
3. Respectez bien la structure des dossiers

### Lancement du Jeu

```bash
dart run main.dart
```

### Règles du Jeu

1. Le plateau est numéroté de 1 à 9 :
   ```
   1 │ 2 │ 3
   ─────────
   4 │ 5 │ 6
   ─────────
   7 │ 8 │ 9
   ```

2. Les joueurs X et O jouent à tour de rôle
3. Pour jouer, entrez le numéro de la case où vous voulez placer votre symbole
4. Le premier joueur qui aligne 3 symboles (horizontalement, verticalement ou en diagonale) gagne
5. Si toutes les cases sont remplies sans gagnant, c'est un match nul

##  Architecture du Code

### Programmation Orientée Objet

Le projet utilise 3 classes principales :

#### 1. **Classe `Jeu`** (game.dart)
- Orchestre le déroulement de la partie
- Gère les tours des joueurs
- Coordonne le plateau et la logique

#### 2. **Classe `Plateau`** (functions/board.dart)
- Représente le plateau de jeu 3x3
- Gère l'affichage visuel
- Permet de placer les symboles
- Vérifie si les cases sont disponibles

#### 3. **Classe `LogiqueJeu`** (functions/game_logic.dart)
- Contient toutes les règles du jeu
- Vérifie les conditions de victoire
- Détecte les matchs nuls
- Identifie les positions disponibles

### Principes Appliqués

- **Encapsulation** : Les données sont protégées avec des attributs privés (_)
- **Modularité** : Chaque classe a une responsabilité unique
- **Réutilisabilité** : Le code peut être facilement étendu (ex: ajouter une IA)
- **Lisibilité** : Commentaires en français pour les débutants

##  Personnalisation

### Ajouter une IA

Vous pouvez facilement ajouter un joueur IA en :
1. Créant une nouvelle classe `JoueurIA` dans `functions/`
2. Utilisant la méthode `obtenirPositionsDisponibles()` de `LogiqueJeu`
3. Implémentant un algorithme (aléatoire, minimax, etc.)

### Modifier l'Affichage

Pour personnaliser l'apparence du plateau, modifiez la méthode `afficher()` dans `board.dart`.

##  Pour les Débutants

### Concepts Utilisés

- **Classes et Objets** : Le jeu est divisé en entités logiques
- **Encapsulation** : Utilisation de `_` pour les attributs privés
- **Getters** : Accès contrôlé aux données avec `get`
- **Listes** : Stockage des cases du plateau
- **Boucles** : Pour parcourir les combinaisons gagnantes
- **Conditions** : Pour valider les coups et vérifier les victoires

### Pourquoi cette Architecture ?

1. **Séparation des responsabilités** : Chaque fichier a un rôle précis
2. **Facilité de maintenance** : Modifier une partie n'affecte pas les autres
3. **Testabilité** : Chaque classe peut être testée indépendamment
4. **Évolutivité** : Facile d'ajouter de nouvelles fonctionnalités

##  Licence

Projet éducatif libre d'utilisation.

##  Contribution

N'hésitez pas à améliorer ce code et à partager vos modifications !

---

**Bon jeu ! **