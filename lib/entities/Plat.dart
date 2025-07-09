import 'package:restaurant_ar/entities/Commentaire.dart';
import 'package:restaurant_ar/entities/User.dart';

class Plat {
  final String id;
  final String nom;
  final String description;
  final double prix;
  final String categorie;
  final String image;

  List<User> likes = [];
  List<User> dislikes = [];
  List<Commentaire> commentaires = [];

  Plat({
    required this.id,
    required this.nom,
    required this.description,
    required this.prix,
    required this.categorie,
    required this.image,
  });

  @override
  bool operator ==(Object other) => other is Plat && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
