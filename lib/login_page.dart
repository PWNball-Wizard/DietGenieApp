import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'screens/diet_form_screen.dart'; // Asegúrate de que esta ruta sea correcta

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _handleSignIn() async {
    try {
      GoogleSignInAccount? result = await _googleSignIn.signIn();
      if (result != null) {
        print("Inicio de sesión exitoso");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DietFormScreen()),
        );
      } else {
        print("Inicio de sesión fallido");
      }
    } catch (error) {
      print("Error al iniciar sesión: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
              width: 272,
              height: 92,
            ),
            SizedBox(height: 48),
            ElevatedButton(
              onPressed: _handleSignIn,
              child: Text('Inicia sesión con Google'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                textStyle: TextStyle(fontSize: 16),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
