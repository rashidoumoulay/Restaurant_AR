import 'package:flutter/material.dart';
import 'package:restaurant_ar/views/APropos.dart';
import 'package:restaurant_ar/views/Login_view.dart';
import 'package:restaurant_ar/views/Menu.dart';
import 'package:restaurant_ar/views/Profil_view.dart';

import 'package:restaurant_ar/views/AjoutPlatPage.dart';
import 'package:restaurant_ar/views/RegisterPage.dart';
import 'views/Accueil.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accueil',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Acceuil'),
        '/login': (context) => const LoginView(),
        '/profil': (context) => const ProfilView(),
        '/menu' : (context) => const MenuPage(title: 'Menu'),
        "/ajouterPlat": (context) => const AjoutPlatPage(),
        "/aPropos" : (context) => const AProposPage(),
        "/register" : (context) => const RegisterView(),
      },
    );
  }
}