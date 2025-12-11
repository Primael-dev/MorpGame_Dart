import 'package:flutter/material.dart';
// Importe notre logique de jeu depuis le fichier que nous venons de créer
import 'morpion_logic.dart'; 

void main() {
  runApp(const MorpionApp());
}

class MorpionApp extends StatelessWidget {
  const MorpionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morpion Flutter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // Le widget MorpionScreen gérera toute l'interface
      home: const MorpionScreen(), 
    );
  }
}

// MorpionScreen est un StatefulWidget car l'état de la grille et du score change
class MorpionScreen extends StatefulWidget {
  const MorpionScreen({super.key});

  @override
  State<MorpionScreen> createState() => _MorpionScreenState();
}

class _MorpionScreenState extends State<MorpionScreen> {
  // Instance de notre classe de logique Morpion
  final Morpion jeu = Morpion();
  
  String messageStatut = "Au tour de X";
  bool jeuActif = true; // Pour bloquer les clics après une victoire/nul

  // Initialisation du widget (appelé une seule fois)
  @override
  void initState() {
    super.initState();
    // Initialiser le premier message de statut
    _updateStatutMessage();
  }
  
  // --- Méthode pour jouer un coup depuis l'UI ---
  void _handleClick(int index) {
    // Si la case est déjà jouée ou si le jeu est terminé, on ignore le clic
    if (!jeuActif || jeu.grille[index] != '') {
      return;
    }

    // Appeler la méthode de la logique
    EtatPartie resultat = jeu.jouerCoup(index);
    
    // Mettre à jour l'interface suite au résultat
    setState(() {
      _updateStatutMessage(resultat);
      
      if (resultat == EtatPartie.victoire || resultat == EtatPartie.nul) {
        jeuActif = false;
      }
    });
  }
  
  // Met à jour le message affiché à l'utilisateur
  void _updateStatutMessage([EtatPartie resultat = EtatPartie.enCours]) {
    switch (resultat) {
      case EtatPartie.victoire:
        messageStatut = "🎉 ${jeu.joueurActuel} a gagné !";
        break;
      case EtatPartie.nul:
        messageStatut = "🤝 Match Nul !";
        break;
      case EtatPartie.enCours:
      default:
        // Si le jeu continue, c'est au tour du joueur qui vient d'être mis à jour par la logique
        messageStatut = "Au tour de ${jeu.joueurActuel}";
        break;
    }
  }

  // --- Recommencer la partie ---
  void _resetGame() {
    setState(() {
      jeu.initialiserJeu(); // Réinitialise la grille et le joueur
      jeuActif = true;
      _updateStatutMessage();
    });
  }

  // --- CONSTRUIRE L'INTERFACE ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Morpion POO Flutter'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 1. Affichage du Score
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'SCORE: X = ${jeu.scoreX} | O = ${jeu.scoreO}',
                style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            
            // 2. Message de Statut (qui doit jouer / victoire / nul)
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                messageStatut,
                style: const TextStyle(fontSize: 24.0, color: Colors.teal, fontWeight: FontWeight.w600),
              ),
            ),

            // 3. La Grille de Jeu (3x3)
            SizedBox(
              width: 320,
              height: 320,
              // Le GridView est parfait pour les grilles fixes comme le Morpion
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 colonnes
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return _buildCase(index);
                },
              ),
            ),

            const SizedBox(height: 40),
            
            // 4. Bouton Recommencer
            ElevatedButton.icon(
              onPressed: _resetGame,
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Recommencer la Manche',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Widget pour construire chaque case cliquable de la grille
  Widget _buildCase(int index) {
    return GestureDetector(
      onTap: () => _handleClick(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal, width: 3.0),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.teal.shade50,
        ),
        child: Center(
          child: Text(
            jeu.grille[index], // Affiche 'X' ou 'O'
            style: TextStyle(
              fontSize: 70.0,
              fontWeight: FontWeight.w900,
              color: jeu.grille[index] == 'X' ? Colors.red.shade700 : Colors.blue.shade700,
            ),
          ),
        ),
      ),
    );
  }
}