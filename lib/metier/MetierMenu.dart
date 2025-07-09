import 'package:restaurant_ar/entities/Plat.dart';

class MetierMenu {
  static final MetierMenu _instance = MetierMenu._internal();
  factory MetierMenu() => _instance;
  MetierMenu._internal();

  List<Plat> plats = [
    Plat(id: 'p1', nom: 'Salade César', image: 'assets/images/cesar.jpeg', prix: 30.0, description: 'Laitue...', categorie: 'Entrées'),
    Plat(id: 'p2', nom: 'Tajine Kefta', image: 'assets/images/Tajine.jpeg', prix: 48.0, description: 'Boulettes...', categorie: 'Plats'),
    Plat(id: 'p3', nom: 'Pizza Margherita', image: 'assets/images/pizza.jpeg', prix: 40.0, description: 'Classique italienne.', categorie: 'Plats'),
    Plat(id: 'p4', nom: 'Tiramisu', image: 'assets/images/tiramisu.jpeg', prix: 25.0, description: 'Dessert italien classique.', categorie: 'Desserts'),
  ];
}
