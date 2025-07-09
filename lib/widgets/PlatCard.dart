import 'package:flutter/material.dart';
import '../services/Auth_service.dart';
import '../services/PlatInteraction_service.dart';
import '../entities/Plat.dart';
import '../entities/User.dart';

class PlatCard extends StatefulWidget {
  final Plat plat;
  final User? user;
  final VoidCallback? onUpdated; // Renommé pour inclure suppression/favoris

  const PlatCard({
    super.key,
    required this.plat,
    this.user,
    this.onUpdated,
  });

  @override
  State<PlatCard> createState() => _PlatCardState();
}

class _PlatCardState extends State<PlatCard> {
  final auth = AuthService();
  final interactionService = PlatInteractionService();

  bool estFavori = false;
  bool afficheDetails = false;
  final TextEditingController _commentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      estFavori = widget.user!.favoris.contains(widget.plat);
    }
  }

  void toggleFavori() {
    final user = auth.user;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez vous connecter pour gérer les favoris.")),
      );
      return;
    }

    setState(() {
      if (estFavori) {
        user.retirerFavoris(widget.plat);
      } else {
        user.ajouterFavoris(widget.plat);
      }
      estFavori = !estFavori;
    });

    widget.onUpdated?.call();
  }

  void toggleLike() {
    final user = auth.user;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connectez-vous pour aimer ce plat.")),
      );
      return;
    }

    setState(() {
      interactionService.toggleLike(widget.plat, user);
    });
  }

  void toggleDislike() {
    final user = auth.user;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connectez-vous pour disliker ce plat.")),
      );
      return;
    }

    setState(() {
      interactionService.toggleDislike(widget.plat, user);
    });
  }

  void ajouterCommentaire(String texte) {
    final user = auth.user;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connectez-vous pour commenter.")),
      );
      return;
    }

    if (texte.trim().isEmpty) return;

    setState(() {
      interactionService.ajouterCommentaire(widget.plat, user, texte.trim());
      _commentCtrl.clear();
    });
  }

  void supprimerPlat() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Voulez-vous vraiment supprimer ce plat ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      interactionService.supprimerPlat(widget.plat);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plat supprimé avec succès')),
      );
      widget.onUpdated?.call(); // Rafraîchir la liste dans la vue parente
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = auth.user;
    final bool isAdmin = user?.role == 'admin';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              widget.plat.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.plat.nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text("${widget.plat.prix.toStringAsFixed(2)} MAD",
                          style: const TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: toggleFavori,
                  icon: Icon(
                    estFavori ? Icons.favorite : Icons.favorite_border,
                    color: estFavori ? Colors.red : null,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    setState(() {
                      afficheDetails = !afficheDetails;
                    });
                  },
                ),
                if (isAdmin)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: supprimerPlat,
                  ),
              ],
            ),
          ),
          if (afficheDetails) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.plat.description, style: const TextStyle(fontStyle: FontStyle.italic)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up,
                            color: widget.plat.likes.contains(user) ? Colors.green : null),
                        onPressed: toggleLike,
                      ),
                      Text("${widget.plat.likes.length}"),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.thumb_down,
                            color: widget.plat.dislikes.contains(user) ? Colors.red : null),
                        onPressed: toggleDislike,
                      ),
                      Text("${widget.plat.dislikes.length}"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("Commentaires :", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.plat.commentaires.map((c) {
                      String date = "${c.date.day}/${c.date.month}/${c.date.year}";
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text("• ${c.user.nom} (${date}) : ${c.texte}"),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _commentCtrl,
                    onSubmitted: ajouterCommentaire,
                    decoration: const InputDecoration(
                      hintText: "Ajouter un commentaire...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
