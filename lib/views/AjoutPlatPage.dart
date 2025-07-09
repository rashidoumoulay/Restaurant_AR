import 'package:flutter/material.dart';
import 'package:restaurant_ar/entities/Plat.dart';
import 'package:restaurant_ar/metier/MetierMenu.dart';

class AjoutPlatPage extends StatefulWidget {
  const AjoutPlatPage({super.key});

  @override
  State<AjoutPlatPage> createState() => _AjoutPlatPageState();
}

class _AjoutPlatPageState extends State<AjoutPlatPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _categorieController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final metierMenu = MetierMenu();

  void _ajouterPlat() {
    if (_formKey.currentState!.validate()) {
      final nouveauPlat = Plat(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nom: _nomController.text.trim(),
        description: _descController.text.trim(),
        prix: double.tryParse(_prixController.text.trim()) ?? 0.0,
        categorie: _categorieController.text.trim(),
        image: _imageController.text.trim(),
      );
      metierMenu.plats.add(nouveauPlat);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Plat ajouté avec succès !")),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un plat")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: "Nom du plat"),
                validator: (value) => value == null || value.isEmpty ? "Champ requis" : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) => value == null || value.isEmpty ? "Champ requis" : null,
              ),
              TextFormField(
                controller: _prixController,
                decoration: const InputDecoration(labelText: "Prix"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final prix = double.tryParse(value ?? '');
                  if (prix == null || prix <= 0) return "Prix invalide";
                  return null;
                },
              ),
              TextFormField(
                controller: _categorieController,
                decoration: const InputDecoration(labelText: "Catégorie"),
                validator: (value) => value == null || value.isEmpty ? "Champ requis" : null,
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: "URL de l'image"),
                validator: (value) => value == null || value.isEmpty ? "Champ requis" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Ajouter"),
                onPressed: _ajouterPlat,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
