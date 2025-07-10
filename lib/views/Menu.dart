import 'package:flutter/material.dart';
import 'package:restaurant_ar/entities/Plat.dart';
import 'package:restaurant_ar/services/Auth_service.dart';
import 'package:restaurant_ar/metier/MetierMenu.dart';
import 'package:restaurant_ar/widgets/PlatCard.dart';
import 'package:restaurant_ar/widgets/Drawer.dart'; // Correct import AppDrawer

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.title});
  final String title;
  @override
  State createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final AuthService auth = AuthService(); // [14]
  final MetierMenu menu = MetierMenu();
  bool get isConnected => auth.user != null;

  @override
  Widget build(BuildContext context) {
    final user = auth.user;
    final categories = menu.plats.map((p) => p.categorie).toSet().toList();
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          // Couleur de l'AppBar uniforme
          backgroundColor: Color(0xFF4A2C2A), // Brun foncé/Café [Conversation History]
          title: const Text("Restaurant AR", style: TextStyle(color: Colors.white)), // Texte blanc [Conversation History]
          centerTitle: true,
          actions: [
            if (!isConnected)
              TextButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/login'); // [15]
                  setState(() {});
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Texte blanc gras
                ),
              )
            else
              IconButton(
                icon: const Icon(Icons.account_circle),
                color: Colors.white, // Icône blanche pour le profil
                onPressed: () async {
                  await Navigator.pushNamed(context, '/profil');
                  setState(() {});
                },
              )
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: Color(0xFFE89A3B), // Couleur d'accent pour l'onglet sélectionné [Conversation History]
            unselectedLabelColor: Colors.white70, // Blanc cassé pour les non sélectionnés [Conversation History]
            indicatorColor: Color(0xFFE89A3B), // Couleur d'accent pour l'indicateur [13, Conversation History]
            tabs: categories.map((cat) => Tab(text: cat)).toList(),
          ),
        ),
        drawer: AppDrawer( // [15]
          user: auth.user, // [11]
          onLogout: () {
            setState(() {
              auth.logout();
            });
          },
          onPlatAjoute: () {
            setState(() {}); // Rafraîchit la liste des plats après ajout
          },
        ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset('assets/images/background1.png', fit: BoxFit.cover), // [11]
            ),
            // Overlay sombre semi-transparent pour améliorer le contraste avec le texte et les cartes
            Container(color: Color.fromARGB(150, 30, 30, 30)), // Plus foncé que l'original [Conversation History]
            TabBarView(
              children: categories.map((cat) {
                final platsParCat = menu.plats.where((p) => p.categorie == cat).toList();
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: GridView.count(
                    shrinkWrap: true, // [13]
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: platsParCat.map((plat) {
                      return PlatCard(plat: plat, user: user ,onUpdated: () {
                        setState(() {});
                      },);
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}