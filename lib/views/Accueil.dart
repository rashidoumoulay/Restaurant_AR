import 'package:flutter/material.dart';
import 'package:restaurant_ar/services/Auth_service.dart';
import 'package:restaurant_ar/widgets/Drawer.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = auth.user;
    final isConnected = user != null; 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Restaurant AR"),
        centerTitle: true,
        actions: [
          if (!isConnected)
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushNamed(context, '/profil');
              },
            )
        ],
      ),
      drawer: AppDrawer(
        user: user,
        onLogout: () {
          setState(() {
            auth.logout();
          });
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
      body: Container(
        color: Colors.amberAccent,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Aji Naklo",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Bienvenue dans l’application officielle de Restaurant AR, votre destination gourmande préférée !",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Découvrez notre menu riche et varié, passez vos commandes en quelques clics, réservez une table à l’avance, et profitez d’une expérience culinaire unique — le tout depuis votre smartphone.",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Que vous soyez amateur de cuisine traditionnelle, de plats modernes ou de desserts raffinés, notre équipe vous propose des produits frais et une ambiance chaleureuse.",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        height: 1.5,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
