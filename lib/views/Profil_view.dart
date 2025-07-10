import 'package:flutter/material.dart';
import '../services/Auth_service.dart';
import '../entities/Plat.dart';
import '../widgets/PlatCard.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});
  @override
  State createState() => _ProfilState();
}

class _ProfilState extends State<ProfilView> {
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = auth.user;
    return Scaffold(
      appBar: AppBar(
        // Style de l'AppBar consistent avec la page de connexion
        backgroundColor: Color(0xFF4A2C2A), // Brun foncé/Café [Conversation History]
        title: const Text("Profil utilisateur", style: TextStyle(color: Colors.white)), // Texte blanc [Conversation History]
        iconTheme: const IconThemeData(color: Colors.white), // Flèche retour blanche
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // [2]
        child: user == null
            ? const Center(child: Text("Aucun utilisateur connecté", style: TextStyle(color: Colors.black54))) // Couleur pour texte sur fond clair
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFFE89A3B), // Utiliser la couleur d'accent (orange/doré) [Conversation History]
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Nom : ${user.nom}",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black87, // Couleur du texte pour un fond clair
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Email : ${user.email}", // [3]
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black87, // Couleur du texte pour un fond clair
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text("Se déconnecter"),
                      onPressed: () {
                        setState(() {
                          auth.logout();
                        });
                        Navigator.pushReplacementNamed(context, "/");
                      },
                      // Style du bouton consistent avec la page de connexion
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE89A3B), // Couleur du bouton (orange/doré) [Conversation History]
                        foregroundColor: Colors.white, // Couleur du texte du bouton [Conversation History]
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bords arrondis [Conversation History]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Vos favoris :", // [3]
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, // Couleur du texte
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: user.favoris.isEmpty
                        ? const Center(child: Text("Aucun plat favori pour l'instant.", style: TextStyle(color: Colors.black54))) // Couleur pour texte sur fond clair
                        : GridView.count(
                            crossAxisCount: 2, // [4]
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4,
                            children: (user.favoris as List)
                                .map((plat) => PlatCard(
                                      plat: plat,
                                      user: user,
                                      onUpdated: () {
                                        setState(() {});
                                      },
                                    ))
                                .toList(),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}