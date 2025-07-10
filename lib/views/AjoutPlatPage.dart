import 'package:flutter/material.dart';
import 'package:restaurant_ar/entities/Plat.dart';
import 'package:restaurant_ar/metier/MetierMenu.dart';

class AjoutPlatPage extends StatefulWidget {
  const AjoutPlatPage({super.key});
  @override
  State createState() => _AjoutPlatPageState();
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
      appBar: AppBar(
        // Style de l'AppBar consistent
        backgroundColor: Color(0xFF4A2C2A), 
        title: const Text("Ajouter un plat", style: TextStyle(color: Colors.white)), 
        iconTheme: const IconThemeData(color: Colors.white), // Flèche retour blanche
      ),
      body: Stack( 
        children: [
          SizedBox.expand(
            child: Image.asset('assets/images/background1.png', fit: BoxFit.cover), 
          ),
          Container(
            color: Color.fromARGB(220, 30, 30, 30), 
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextFormField(
                    controller: _nomController,
                    labelText: "Nom du plat", // [8]
                  ),
                  SizedBox(height: 15),
                  _buildTextFormField(
                    controller: _descController,
                    labelText: "Description",
                  ),
                  SizedBox(height: 15),
                  _buildTextFormField(
                    controller: _prixController,
                    labelText: "Prix", // [9]
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final prix = double.tryParse(value ?? '');
                      if (prix == null || prix <= 0) return "Prix invalide";
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  _buildTextFormField(
                    controller: _categorieController,
                    labelText: "Catégorie",
                  ),
                  SizedBox(height: 15),
                  _buildTextFormField(
                    controller: _imageController,
                    labelText: "URL de l'image",
                  ),
                  const SizedBox(height: 30), 
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Ajouter"),
                    onPressed: _ajouterPlat,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE89A3B), 
                      foregroundColor: Colors.white, 
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 50), // Bouton pleine largeur
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
 Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white), 
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 18,
          color: Colors.white70, 
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1), 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none, 
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Color(0xFFE89A3B), width: 2), 
        ),
        errorStyle: TextStyle(color: Colors.red), 
      ),
      keyboardType: keyboardType,
      validator: validator ?? (value) => value == null || value.isEmpty ? "Champ requis" : null,
    );
  }
}