import 'package:flutter/material.dart';
import 'package:restaurant_ar/views/APropos.dart';
import '../services/Auth_service.dart';
import '../entities/User.dart';
import '../views/AjoutPlatPage.dart'; // N’oublie pas d’importer ta page AjoutPlatPage

class AppDrawer extends StatelessWidget {
  final User? user;
  final VoidCallback onLogout;
  final VoidCallback? onPlatAjoute; // Callback pour notifier un ajout de plat

  const AppDrawer({
    super.key,
    required this.user,
    required this.onLogout,
    this.onPlatAjoute,
  });

  @override
  Widget build(BuildContext context) {
    final bool isConnected = user != null;
    final bool isAdmin = user?.role == 'admin';

    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Opacity(
                      opacity: 0.2, 
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(158, 96, 125, 139),
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Text('AJI NAKLO',
                          style: TextStyle(
                            color: Color.fromARGB(255, 190, 166, 85),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 20),
                      Text(
                        user?.nom ?? 'Invité',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 243, 194, 33),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ]),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Accueil'),
                  onTap: () => Navigator.pushReplacementNamed(context, '/'),
                ),
                ListTile(
                  leading: const Icon(Icons.menu),
                  title: const Text('Menu'),
                  onTap: () => Navigator.pushReplacementNamed(context, '/menu'),
                ),

                if (isAdmin)
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Ajouter un plat'),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AjoutPlatPage()),
                      );

                      if (result == true && onPlatAjoute != null) {
                        onPlatAjoute!(); // Notifie la page parente pour rafraîchir
                      }
                      Navigator.pop(context); // Ferme le drawer après retour
                    },
                  ),

                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('À propos'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AProposPage()),
                    );
                  },
                ),
              ],
            ),
            Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              child: ListTile(
                leading: Icon(
                  isConnected ? Icons.logout : Icons.login,
                  color: isConnected ? Colors.red : Colors.blue,
                ),
                title: Text(
                  isConnected ? 'Déconnexion' : 'Login',
                  style: TextStyle(color: isConnected ? Colors.red : Colors.blue),
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
