import "../entities/User.dart";

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal() {
    // Initialiser la liste avec des utilisateurs par défaut pour la démonstration
    // En production, cette liste proviendrait d'une base de données ou d'un stockage persistant
    _users.add(User(id: '1', nom: 'Admin', email: 'admin@aaro.com', role: "admin", password: '1234')); // Supposons que User a maintenant un champ password
    _users.add(User(id: '2', nom: 'Client1', email: 'client1@aaro.com', role: "user", password: '1234')); // Supposons que User a maintenant un champ password
    // Il est important de noter que le mot de passe ne devrait jamais être stocké en texte clair en production.
    // Il faudrait utiliser des techniques de hachage de mot de passe.
  }

  User? _user;
  User? get user => _user;

  // Nouvelle liste pour stocker tous les utilisateurs enregistrés
  final List<User> _users = [];

  // Nouvelle fonction pour l'enregistrement (register)
  Future<bool> register(String nom, String email, String password, String role) async {
    // Vérifier si un utilisateur avec cet email existe déjà
    if (_users.any((u) => u.email == email)) {
      print("Erreur: Un utilisateur avec cet email existe déjà."); // Information en dehors des sources
      return false; 
    }

    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nom: nom,
      email: email,
      role: role,
      password: password, 
    );

    _users.add(newUser);
    print("Utilisateur ${newUser.email} enregistré avec succès."); 

    _user = newUser;
    return true; 
  }
   Future<bool> login(String email, String password) async {
    // Rechercher l'utilisateur dans la liste _users
    final foundUser = _users.firstWhere(
      (u) => u.email == email && u.password == password, // Assurez-vous que User a un champ password
      orElse: () => null as User, // Retourne null si aucun utilisateur n'est trouvé.
                                  // Note: 'null as User' est une astuce pour éviter une erreur de type avec null-safety
                                  // Une meilleure pratique serait de gérer cela avec un try-catch ou un .where().isEmpty
    );

    if (foundUser != null) {
      _user = foundUser; // Définir l'utilisateur connecté
      return true; // Connexion réussie
    }

    return false; // Email ou mot de passe incorrect
  }

  void logout() {
    _user = null;
  }

  bool isLoggedIn() {
    return _user != null;
  }
}
