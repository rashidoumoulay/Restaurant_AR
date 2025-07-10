import 'package:restaurant_ar/entities/Plat.dart';

class User {
  final String id;
  final String nom;
  final String email;
  final String password;
  final String role;
  List<Plat> favoris ;

  User({
    required this.id,
    required this.nom,
    required this.email,
    required this.password,
    required this.role,
    List<Plat>? favoris, 
  }) : favoris = favoris ?? [];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nom: json['nom'],
      email: json['email'],
      password: json['password'],
      role : json['role'],
      favoris: json['favoris'],
    );
  }
  void ajouterFavoris(Plat plat) {
    if (!favoris.contains(plat)) {
      favoris.add(plat);
    }
  }

  void retirerFavoris(Plat plat) {
    favoris.remove(plat);
  }

  bool aDansFavoris(Plat plat) {
    return favoris.contains(plat);
  }
  @override
  bool operator ==(Object other) => other is User && other.email == email;

  @override
  int get hashCode => email.hashCode;


}