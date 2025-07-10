import 'package:flutter/material.dart';

class AProposPage extends StatelessWidget {
  const AProposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('À propos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'AJI NAKLO',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Bienvenue chez AJI NAKLO, un restaurant fondé en 2025, '
              'spécialisé dans la cuisine marocaine traditionnelle avec une touche moderne. '
              'Notre mission est de vous offrir une expérience culinaire authentique et savoureuse.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const Divider(height: 40),
            const Text(
              'Développeurs de l\'application',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Center(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row( // C'est cette Row qui causait l'overflow [Previous conversation]
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/images/rashid.jpg'),
                            ),
                            const SizedBox(height: 10),
                            // Début de la modification pour le texte d'Oumoulay Rashid [1]
                            const Text(
                              'Oumoulay Rashid\nDéveloppeur Flutter & Backend\nEmail: oumoulayrashid2022@gmail.com\nGitHub: github.com/rashidoumoulay',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                              maxLines: 4, // Permet 4 lignes pour le nom, rôle, email et GitHub**
                              overflow: TextOverflow.ellipsis, // Tronque avec des points de suspension si le texte est trop long horizontalement**
                            ),
                            // Fin de la modification
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/images/ayyoub.jpg'),
                            ),
                            const SizedBox(height: 10),
                            // Début de la modification pour le texte d'Ait Mansour Ayyoub [2]
                            const Text(
                              'Ait Mansour Ayyoub\nDéveloppeur Flutter & Backend\nEmail: ayyoub@gmail.com\nGitHub: github.com/ayyoub',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                              maxLines: 4, // Permet 4 lignes pour le nom, rôle, email et GitHub**
                              overflow: TextOverflow.ellipsis, // Tronque avec des points de suspension si le texte est trop long horizontalement**
                            ),
                            // Fin de la modification
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Version de l\'application : 1.0.0\nDernière mise à jour : juillet 2025',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}