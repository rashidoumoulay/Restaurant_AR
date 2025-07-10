import 'package:flutter/material.dart';
import '../services/Auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _login() async {
    bool success = await AuthService().login(
      _emailController.text,
      _passwordController.text,
    );
    if (success) {
      setState((){
        //Navigator.pushReplacementNamed(context, '/', arguments :true);
        Navigator.pop(context);
      });
    } else {
      setState(() {
        _errorMessage = "Email ou mot de passe incorrect";
      });
    }
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Nouvelle couleur pour la barre d'application
        backgroundColor: Color(0xFF4A2C2A), // Brun foncé/Café
        title: const Text(
          "Connexion",
          style: TextStyle(color: Colors.white), // Texte du titre en blanc
        ),
      ),
      body: Stack(
        children: [
          // 🔵 Image de fond
          SizedBox.expand(
            child: Image.asset(
              'assets/images/logo.png', // Maintenir l'image de fond
              fit: BoxFit.cover,
            ),
          ),
          // Conteneur extérieur avec padding ajusté
          Container(
            padding: const EdgeInsets.all(40), // Padding réduit
            child: Container(
              padding: EdgeInsets.all(30),
              // Nouvelle couleur pour l'arrière-plan du formulaire (noir semi-transparent)
              color: Color.fromARGB(220, 30, 30, 30),
              child: Column(
                mainAxisSize: MainAxisSize.min, // S'adapte au contenu
                children: [
                  TextField(
                    controller: _emailController,
                    // Style du texte en blanc
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        // Couleur de l'étiquette en blanc cassé
                        color: Colors.white70,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1), // Remplissage léger
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Color(0xFFE89A3B), width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    // Style du texte en blanc
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Mot de passe",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        // Couleur de l'étiquette en blanc cassé
                        color: Colors.white70,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1), // Remplissage léger
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Color(0xFFE89A3B), width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  if (_errorMessage != null)
                    Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                  SizedBox(height: 20,), // Ajout d'espacement avant le bouton
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE89A3B), // Couleur du bouton (orange/doré)
                      foregroundColor: Colors.white, // Couleur du texte du bouton
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Bords arrondis
                      ),
                      minimumSize: Size(double.infinity, 50), // Bouton pleine largeur
                    ),
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20), 
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      "Vous n'avez pas de compte? S'inscrire",
                      style: TextStyle(
                        color: Color.fromARGB(255, 219, 224, 191), // Couleur similaire aux autres textes sur la page de login [3, 4]
                        decoration: TextDecoration.underline, // Pour indiquer que c'est cliquable
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
