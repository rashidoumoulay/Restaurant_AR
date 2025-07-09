import 'package:flutter/material.dart';
import 'package:restaurant_ar/entities/Plat.dart';
import 'package:restaurant_ar/services/Auth_service.dart';
import 'package:restaurant_ar/metier/MetierMenu.dart';
import 'package:restaurant_ar/widgets/PlatCard.dart';
import 'package:restaurant_ar/widgets/Drawer.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.title});
  final String title;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final AuthService auth = AuthService();
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
          backgroundColor: Colors.blueGrey,
          title: const Text("Restaurant AR"),
          centerTitle: true,
          actions: [
            if (!isConnected)
              TextButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/login');
                  setState(() {});
                },
                child: const Text("Login", style: TextStyle(color: Colors.white)),
              )
            else
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () async {
                  await Navigator.pushNamed(context, '/profil');
                  setState(() {});
                },
              )
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.amber,
            tabs: categories.map((cat) => Tab(text: cat)).toList(),
          ),
        ),
        drawer: AppDrawer(
            user: auth.user,
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
              child: Image.asset('assets/images/background1.png', fit: BoxFit.cover),
            ),
            Container(color: const Color.fromARGB(131, 200, 221, 104)),
            TabBarView(
              children: categories.map((cat) {
                final platsParCat = menu.plats.where((p) => p.categorie == cat).toList();
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: platsParCat.map((plat) {
                      return PlatCard(plat: plat, user: user ,onUpdated: () {
                                                                setState(() {}); // 🔁 Redessiner l’écran avec la liste mise à jour
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
