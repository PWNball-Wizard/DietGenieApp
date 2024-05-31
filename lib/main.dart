import 'package:dietas/login_page.dart';
import 'package:flutter/material.dart';
import 'screens/diet_form_screen.dart';  // Asegúrate de usar la ruta correcta según donde hayas guardado el archivo

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diet App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DietFormScreen(),  // Configura como pantalla inicial
    );
  }
}

/* import 'package:flutter/material.dart';
import 'login_page.dart'; // Asegúrate de importar correctamente tu nueva pantalla

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),  // Usa aquí tu widget de la pantalla de login
    );
  }
}
 */