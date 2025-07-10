import 'package:flutter/material.dart';
import '../services/Auth_service.dart'; 

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _errorMessage; 

  final AuthService _auth = AuthService(); 

  void _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        setState(() {
          _errorMessage = "Les mots de passe ne correspondent pas.";
        });
        return;
      }

      bool success = await _auth.register(
        _nomController.text,
        _emailController.text,
        _passwordController.text,
        "user",
      );
      // --- Fin de l'information non tirée directement des sources ---

      if (success) {
        // Affiche un SnackBar en cas de succès, similaire à AjoutPlatPage [8]
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Inscription réussie ! Vous pouvez maintenant vous connecter.")),
        );
        // Redirige l'utilisateur, par exemple vers la page de connexion [9] ou la page d'accueil
        Navigator.pop(context); // Retourne à la page précédente (probablement LoginView)
      } else {
        setState(() {
          // Affiche un message d'erreur en cas d'échec [4]
          _errorMessage = "Erreur lors de l'inscription. L'email est peut-être déjà utilisé ou une autre erreur s'est produite.";
        });
      }
    }
  }

  @override
  void dispose() {
    // Il est important de disposer des contrôleurs pour éviter les fuites de mémoire
    _nomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey, // Couleur de l'AppBar similaire à LoginView [9]
        title: const Text("Inscription"),
      ),
      body: Stack( // Utilisation d'un Stack pour l'image de fond, comme dans LoginView [9]
        children: [
          // Image de fond, utilisant une image existante dans les sources [9, 10]
          SizedBox.expand(
            child: Image.asset(
              'assets/images/logo.png', // Ou 'assets/images/background1.png' [6]
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(100), // Rembourrage similaire à LoginView [11]
            child: Container(
              padding: const EdgeInsets.all(30), // Rembourrage intérieur [11]
              color: const Color.fromARGB(181, 96, 125, 139), // Couleur de fond semi-transparente [11]
              child: Form( // Utilisation d'un Form pour la validation des champs [8, 12, 13]
                key: _formKey,
                child: ListView( // ListView permet de défiler si le contenu dépasse l'écran (utile pour le clavier)
                  children: [
                    TextFormField(
                      controller: _nomController,
                      style: const TextStyle(color: Color.fromARGB(255, 219, 224, 191)), // Style de texte cohérent [11]
                      decoration: const InputDecoration(
                        labelText: "Nom",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 219, 224, 191), // Style de label cohérent [11]
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty ? "Le nom est requis" : null, // Validateur [12]
                    ),
                    const SizedBox(height: 20), // Espacement entre les champs [4, 11]
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Color.fromARGB(255, 219, 224, 191)),
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 219, 224, 191),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "L'email est requis";
                        }
                        // Validation de format d'email de base (non directement des sources mais pratique courante)
                        if (!RegExp(r'^[^@]+@[^@.]+\.[^@]+').hasMatch(value)) {
                          return "Veuillez entrer une adresse email valide";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress, // Clavier adapté pour l'email
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true, // Cache le texte pour un mot de passe [4]
                      style: const TextStyle(color: Color.fromARGB(255, 219, 224, 191)),
                      decoration: const InputDecoration(
                        labelText: "Mot de passe",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 219, 224, 191),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Le mot de passe est requis";
                        }
                        // Longueur minimale du mot de passe (non directement des sources mais bonne pratique)
                        if (value.length < 6) {
                          return "Le mot de passe doit contenir au moins 6 caractères";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true, // Cache le texte
                      style: const TextStyle(color: Color.fromARGB(255, 219, 224, 191)),
                      decoration: const InputDecoration(
                        labelText: "Confirmer le mot de passe",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 219, 224, 191),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez confirmer votre mot de passe";
                        }
                        if (value != _passwordController.text) {
                          return "Les mots de passe ne correspondent pas";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30), // Espacement avant le message d'erreur ou le bouton [4]
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red), // Style d'erreur cohérent [4]
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _register, // Appel de la méthode d'inscription
                      child: const Text("S'inscrire"), // Texte du bouton [4, 14]
                    ),
                    const SizedBox(height: 20),
                    TextButton( // Bouton de texte pour naviguer vers la page de connexion
                      onPressed: () {
                        Navigator.pop(context); // Retourne à la page précédente (LoginView)
                      },
                      child: const Text(
                        "Vous avez déjà un compte? Se connecter",
                        style: TextStyle(
                          color: Color.fromARGB(255, 219, 224, 191),
                          decoration: TextDecoration.underline, 
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}