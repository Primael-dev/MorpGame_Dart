Ici vous mettez vos fonctions

      FONCTIONS CREER :
Dans le fichier player.dart 

// Constructeur
Player(String name, String symbol)                    (Constructeur)

// Getters
String getName()                                       (Getter)
String getSymbol()                                     (Getter)
int getScore()                                         (Getter)

// Méthodes
void incrementScore()                                  (Gestion d'état)
void resetScore()                                      (Gestion d'état)
String toString()                                      (Affichage)


Dans le fichier board.dart 
 --classe cell--
// Constructeur
Cell(int row, int col)                                (Constructeur)

// Getters
int getRow()                                          (Getter)
int getCol()                                          (Getter)
String getValue()                                     (Getter)

// Méthodes
bool isEmpty()                                        (Vérification)
void setValue(String value)                           (Gestion d'état)
void clear()                                          (Gestion d'état)
String toString()                                     (Affichage)

--classe board--
// Constructeur
Board()                                               (Constructeur)

// Initialisation
void initializeBoard()                                (Gestion d'état)
void reset()                                          (Gestion d'état)

// Gestion des coups
bool isCellEmpty(int row, int col)                    (Vérification)
bool makeMove(int row, int col, String symbol)        (Gestion d'état)
Cell getCell(int row, int col)                        (Getter)

// Vérifications
bool isFull()                                         (Vérification)
bool isValidPosition(int row, int col)                (Vérification)

// Affichage
void displayBoard()                                   (Affichage)
String toString()                                     (Affichage)

Dans le fichier game_logic.dart 


// Constructeur
GameLogic(Player player1, Player player2)             (Constructeur)
--classe gamelogic--
// Initialisation
void startNewGame()                                   (Gestion d'état)
void resetGame()                                      (Gestion d'état)

// Gestion des tours
bool playTurn(int row, int col)                       (Gestion jeu)
void switchPlayer()                                   (Gestion d'état)
Player getCurrentPlayer()                             (Getter)

// Vérifications de victoire
bool checkWinner()                                    (Vérification)
bool checkRow(int row)                                (Vérification)
bool checkColumn(int col)                             (Vérification)
bool checkMainDiagonal()                              (Vérification)
bool checkAntiDiagonal()                              (Vérification)

// État du jeu
bool isGameOver()                                     (Vérification)
bool isDraw()                                         (Vérification)
String getGameStatus()                                (Getter)
Player? getWinner()                                   (Getter)

// Getters
Board getBoard()                                      (Getter)
int getTurnCount()                                    (Getter)


Dans main.dart 

// Constructeur
Game()                                                (Constructeur)

// Menu et interface
void displayWelcome()                                 (Affichage)
void displayMenu()                                    (Affichage)
void displayRules()                                   (Affichage)
void displayScores()                                  (Affichage)

// Gestion du jeu
void playGame()                                       (Gestion jeu)
void playRound()                                      (Gestion jeu)

// Entrées utilisateur
List<int>? getUserInput()                             (Interaction utilisateur)
List<int>? parseCoordinates(String input)             (Interaction utilisateur)

// Boucles de jeu
bool askReplay()                                      (Interaction utilisateur)

// Affichage
void displayResult()                                  (Affichage)
void clearScreen()                                    (Affichage)
void printSeparator()                                 (Affichage)


FONCTION PRINCIPALE 

  void main ()


Classes principales
1. Classe Cell (dans board.dart)
   Représente une case du plateau

Attributs : int row, int col, String value ('X', 'O')
Méthodes :

bool isEmpty()
void setValue(String value)



2. Classe Board (dans board.dart)
   Gère le plateau 3x3

Attributs : List<List<Cell>> cells
Méthodes :

void initializeBoard() - Initialise le plateau vide
bool isCellEmpty(int row, int col) - Vérifie si case est vide
void makeMove(int row, int col, String symbol) - Place un symbole
void displayBoard() - Affiche le plateau
bool isFull() - Vérifie si le plateau est plein
void reset() - Réinitialise le plateau



3. Classe Player (dans player.dart)
   Représente un joueur

Attributs :

String name
String symbol ('X' ou 'O')
int score


Méthodes :

void incrementScore()
String getSymbol()



4. Classe GameLogic (dans game_logic.dart)
   Cœur du jeu

Attributs :

Board board
Player player1
Player player2
Player currentPlayer
bool gameOver


Méthodes :

void startGame() - Démarre une partie
bool checkWinner() - Vérifie la victoire
bool checkLine(int row) - Vérifie la ligne
bool checkColumn(int col) - Vérifie la colonne
bool checkDiagonals() - Vérifie les diagonales
bool checkDraw() - Vérifie si match nul
void switchPlayer() - Change de joueur
void playTurn(int row, int col) - Joue un tour
String getWinner() - Retourne le gagnant



5. Classe Game (dans main.dart)
   Interface utilisateur console

Méthodes :

void displayMenu() - Menu principal
void getUserInput() - Récupère la saisie
void playGame() - Boucle principale
void displayScores() - Affiche les scores
bool askReplay() - Demande rejouer



