
import 'package:restaurant_ar/entities/Commentaire.dart';
import 'package:restaurant_ar/entities/User.dart';

import '../entities/Plat.dart';
import '../metier/MetierMenu.dart';

class PlatInteractionService {
  static final PlatInteractionService _instance = PlatInteractionService._internal();
  factory PlatInteractionService() => _instance;

  PlatInteractionService._internal() {
    // Charger les plats initiaux depuis MetierMenu
    plats = MetierMenu().plats;
  }

  late List<Plat> plats;

  void supprimerPlat(Plat plat) {
    plats.remove(plat);
  }

  List<Plat> getPlats() {
    return plats;
  }

  void ajouterPlat(Plat plat) {
    plats.add(plat);
  }
  void toggleLike(Plat plat, User user) {
    if (plat.likes.contains(user)) {
      plat.likes.remove(user);
    } else {
      plat.likes.add(user);
      plat.dislikes.remove(user); // retire le dislike si présent
    }
  }

  void toggleDislike(Plat plat, User user) {
    if (plat.dislikes.contains(user)) {
      plat.dislikes.remove(user);
    } else {
      plat.dislikes.add(user);
      plat.likes.remove(user);
    }
  }

  void ajouterCommentaire(Plat plat, User user, String texte) {
    plat.commentaires.add(Commentaire(user: user, texte: texte, date: DateTime.now()));
  }

}
