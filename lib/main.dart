import 'package:dam_u2_proyecto2/mostrar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String _validUser = 'Admin';
  final String _validPassword = '1234';
  String _errorMessage = '';

  void _login() {
    String enteredUser = _userController.text;
    String enteredPassword = _passwordController.text;
    if (enteredUser == _validUser && enteredPassword == _validPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Mostrar()),
      );
    } else {
      setState(() {
        _errorMessage = ' Usuario o contraseña incorrectos ';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fondo2.jpg"), // Reemplaza con la ruta de tu imagen de fondo
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "WELCOME",
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontWeight: FontWeight.w100
                ),
              ),

                    TextField(
                      controller: _userController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(labelText: 'Usuario',labelStyle:TextStyle(color: Colors.white),),

                    ),
                    TextField(
                      controller: _passwordController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(labelText: 'Contraseña',labelStyle:TextStyle(color: Colors.white)),
                      obscureText: true,
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Iniciar sesión'),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.white,backgroundColor:Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

