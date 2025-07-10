import 'package:flutter/material.dart';
import '../services/Auth_service.dart';
import '../entities/User.dart';
import '../views/AjoutPlatPage.dart';
import 'package:restaurant_ar/views/APropos.dart'; // Correct import

class AppDrawer extends StatelessWidget {
  final User? user; // [16]
  final VoidCallback onLogout;
  final VoidCallback? onPlatAjoute;

  const AppDrawer({
    super.key,
    required this.user,
    required this.onLogout,
    this.onPlatAjoute, // [17]
  });

  @override
  Widget build(BuildContext context) {
    final bool isConnected = user != null; // [17]
    final bool isAdmin = user?.role == 'admin';
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  // Style du DrawerHeader
                  decoration: BoxDecoration(
                    color: Color(0xFF4A2C2A), // Couleur de fond sombre pour le DrawerHeader [Conversation History]
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image de fond avec opacité
                      Opacity(
                        opacity: 0.2, // Opacité légère
                        child: Image.asset(
                          'assets/images/logo.png', // [17]
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Overlay pour améliorer le contraste du texte
                      Container(
                        color: Colors.black.withOpacity(0.4), // Overlay plus sombre et moderne [Conversation History]
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center, // [18]
                        children: [
                          const SizedBox(height: 20),
                          const Text('AJI NAKLO',
                              style: TextStyle(
                                color: Color(0xFFE89A3B), // Couleur d'accent pour le nom de l'app [Conversation History]
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 20),
                          Text(
                            user?.nom ?? 'Invité',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white, // Blanc pour le nom de l'utilisateur/invité [Conversation History]
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ]),
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.black87), // Icône sombre sur fond clair
                  title: const Text('Accueil', style: TextStyle(color: Colors.black87)),
                  onTap: () => Navigator.pushReplacementNamed(context, '/'),
                ),
                ListTile(
                  leading: const Icon(Icons.menu, color: Colors.black87), // [19]
                  title: const Text('Menu', style: TextStyle(color: Colors.black87)),
                  onTap: () => Navigator.pushReplacementNamed(context, '/menu'),
                ),
                if (isAdmin)
                  ListTile(
                    leading: const Icon(Icons.add, color: Colors.black87),
                    title: const Text('Ajouter un plat', style: TextStyle(color: Colors.black87)),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AjoutPlatPage()),
                      );
                      if (result == true && onPlatAjoute != null) {
                        onPlatAjoute!();
                      }
                      Navigator.pop(context);
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.black87), // [20]
                  title: const Text('À propos', style: TextStyle(color: Colors.black87)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AProposPage()),
                    );
                  },
                ),
              ],
            ),
            // Bouton de connexion/déconnexion en bas du Drawer
            Container(
              width: double.infinity,
              color: Colors.grey.shade100, // Fond légèrement plus clair pour le bas
              child: ListTile(
                leading: Icon(
                  isConnected ? Icons.logout : Icons.login,
                  color: isConnected ? Colors.red.shade700 : Color(0xFFE89A3B), // Rouge foncé pour déconnexion, accent pour connexion [Conversation History]
                ),
                title: Text(
                  isConnected ? 'Déconnexion' : 'Login', // [21]
                  style: TextStyle(color: isConnected ? Colors.red.shade700 : Color(0xFF4A2C2A), fontWeight: FontWeight.bold), // Texte assorti à l'icône, ou brun foncé pour Login [Conversation History]
                ),
                onTap: () {
                  if (isConnected) {
                    onLogout();
                    Navigator.pushReplacementNamed(context, '/');
                  } else {
                    Navigator.pushNamed(context, '/login');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}