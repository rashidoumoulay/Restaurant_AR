import 'package:flutter/material.dart';
import '../services/Auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _login() async {
    bool success = await AuthService().login(
      _emailController.text,
      _passwordController.text,
    );
    if (success) {
      setState((){
        //Navigator.pushReplacementNamed(context, '/', arguments :true);
        Navigator.pop(context);
      });
    } else {
      setState(() {
        _errorMessage = "Email ou mot de passe incorrect";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Connexion")),
      body: 
      Stack(
        children: [
          // 🔵 Image de fond
          SizedBox.expand(
            child: Image.asset(
              'assets/images/background1.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(100),
            
            child: Container(
              padding: EdgeInsets.all(30),
              color :  const Color.fromARGB(181, 96, 125, 139),
              child : Column(
              
              children: [
                TextField(controller: _emailController,
                  style: TextStyle(color: Color.fromARGB(255, 219, 224, 191)),
                  decoration: const InputDecoration(labelText: "Email",
                    labelStyle: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 219, 224, 191)
                    ),)
                ),
                SizedBox(height: 20,),
                TextField(controller: _passwordController, obscureText: true, 
                        style: TextStyle(color: Color.fromARGB(255, 219, 224, 191)),
                        decoration: const InputDecoration(labelText: "Mot de passe",
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 219, 224, 191)
                ))),
                SizedBox(height: 30,),
                if (_errorMessage != null) Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                ElevatedButton(onPressed: _login, child: const Text("Se connecter")),
              ],
            ),
            ),
            
            
          ),
        ],),
    );
  }
}
