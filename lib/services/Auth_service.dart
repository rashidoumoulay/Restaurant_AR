import "../entities/User.dart";

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();
  
  User? _user;

  User? get user => _user;

  Future<bool> login(String email, String password) async {
    // Ici on simule une vérification
    if (email == "admin@aaro.com" && password == "1234") {
      _user = User(id: '1', nom: 'Admin', email: email , role: "admin");
      return true;
    }else if (email == "client1@aaro.com" && password == "1234"){
      _user = User(id: '2', nom: 'Client1', email: email , role: "user");
      return true;
    }
    return false;
  }

  void logout() {
    _user = null;
  }

  bool isLoggedIn() {
    return _user != null;
  }
}
