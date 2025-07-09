import 'package:flutter/material.dart';
import 'package:restaurant_ar/services/Auth_service.dart';
import '../entities/Plat.dart';
import '../entities/Commentaire.dart';

class PlatDetailsSheet extends StatefulWidget {
  final Plat plat;
  const PlatDetailsSheet({super.key, required this.plat});

  @override
  State<PlatDetailsSheet> createState() => _PlatDetailsSheetState();
}

class _PlatDetailsSheetState extends State<PlatDetailsSheet> {
  int likes = 0;
  int dislikes = 0;
  List<Commentaire> commentaires = [];
  final TextEditingController _commentCtrl = TextEditingController();
  final auth = AuthService();

  @override
  void initState() {
    super.initState();
    commentaires = List.from(widget.plat.commentaires);
    likes = widget.plat.likes.length;
    dislikes = widget.plat.dislikes.length;
  }

  void ajouterCommentaire() {
    final user = auth.user;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez vous connecter pour commenter.")),
      );
      return;
    }

    if (_commentCtrl.text.trim().isEmpty) return;

    setState(() {
      commentaires.add(Commentaire(
        user: user,
        texte: _commentCtrl.text.trim(),
        date: DateTime.now(),
      ));
      _commentCtrl.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.plat.nom, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            
            // ✅ Description du plat
            if (widget.plat.description.isNotEmpty)
              Text(
                widget.plat.description,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),

            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.green),
                  onPressed: () => setState(() => likes++),
                ),
                Text('$likes Likes'),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.thumb_down, color: Colors.red),
                  onPressed: () => setState(() => dislikes++),
                ),
                Text('$dislikes Dislikes'),
              ],
            ),
            const Divider(),
            Text("Commentaires :", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            for (final c in commentaires)
              ListTile(
                title: Text(c.texte),
                subtitle: Text("Par ${c.user.nom} le ${c.date.toLocal().toString().split(' ')[0]}"),
              ),
            TextField(
              controller: _commentCtrl,
              decoration: const InputDecoration(
                labelText: "Ajouter un commentaire",
                suffixIcon: Icon(Icons.send),
              ),
              onSubmitted: (_) => ajouterCommentaire(),
            ),
          ],
        ),
      ),
    );
  }
}
