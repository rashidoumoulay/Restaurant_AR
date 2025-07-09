import 'User.dart';

class Commentaire {
  final User user;
  final String texte;
  final DateTime date;

  Commentaire({
    required this.user,
    required this.texte,
    required this.date,
  });
}
