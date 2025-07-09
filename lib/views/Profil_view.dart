import 'package:flutter/material.dart';
import '../services/Auth_service.dart';
import '../entities/Plat.dart';
import '../widgets/PlatCard.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});
  @override
  State<ProfilView> createState() => _ProfilState();
}

class _ProfilState extends State<ProfilView> {
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil utilisateur"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: user == null
            ? const Center(child: Text("Aucun utilisateur connecté"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.amber,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text("Nom : ${user.nom}", style: Theme.of(context).textTheme.titleMedium),
                  ),
                  Center(
                    child: Text("Email : ${user.email}", style: Theme.of(context).textTheme.titleMedium),
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
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Vos favoris :",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: user.favoris.isEmpty
                        ? const Center(child: Text("Aucun plat favori pour l'instant."))
                        : GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4,
                            children: (user.favoris as List<Plat>)
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
