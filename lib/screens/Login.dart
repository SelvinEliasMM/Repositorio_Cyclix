import 'package:flutter/material.dart';
import 'register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String usuarioGuardado = "admin";
  String passwordGuardado = "1234";

  void login() {
    if (userController.text == usuarioGuardado &&
        passController.text == passwordGuardado) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login correcto")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Datos incorrectos")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN", style: TextStyle(fontSize: 28)),

            TextField(
              controller: userController,
              decoration: InputDecoration(labelText: "Usuario"),
            ),

            TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Contraseña"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: login,
              child: Text("Ingresar"),
            ),

            TextButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterScreen()),
                );

                if (result != null) {
                  setState(() {
                    usuarioGuardado = result['user'];
                    passwordGuardado = result['pass'];
                  });
                }
              },
              child: Text("Crear cuenta"),
            )
          ],
        ),
      ),
    );
  }
}