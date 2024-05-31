import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dietas/screens/diet_details_screen.dart'; // Asegúrate de que la ruta sea correcta
import 'package:dietas/user_data.dart'; // Asegúrate de que este archivo esté bien definido

class DietFormScreen extends StatefulWidget {
  @override
  _DietFormScreenState createState() => _DietFormScreenState();
}

class _DietFormScreenState extends State<DietFormScreen> {
  final _formKey = GlobalKey<FormState>();
  UserData userData = UserData(gender: 'Masculino', activityLevel: 'Muy activo'); // Valores predeterminados en español
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario de Ingreso de Dieta"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            DropdownButtonFormField(
              value: userData.gender,
              onChanged: (String? newValue) {
                setState(() {
                  userData.gender = newValue!;
                });
              },
              items: <String>['Masculino', 'Femenino', 'Otro']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Género',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Este campo no puede estar vacío';
                final number = int.tryParse(value);
                if (number == null) return 'Ingrese un número válido';
                if (number <= 0) return 'Ingrese un número mayor que cero';
                return null;
              },
              onSaved: (value) {
                userData.weight = int.parse(value ?? '0');
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Este campo no puede estar vacío';
                final number = int.tryParse(value);
                if (number == null) return 'Ingrese un número válido';
                if (number <= 0) return 'Ingrese un número mayor que cero';
                return null;
              },
              onSaved: (value) {
                userData.height = int.parse(value ?? '0');
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Este campo no puede estar vacío';
                final number = int.tryParse(value);
                if (number == null) return 'Ingrese un número válido';
                if (number <= 0 || number > 120) return 'Ingrese una edad válida (1-120)';
                return null;
              },
              onSaved: (value) {
                userData.age = int.parse(value ?? '0');
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              value: userData.activityLevel,
              onChanged: (String? newValue) {
                setState(() {
                  userData.activityLevel = newValue!;
                });
              },
              items: <String>[
                'Muy activo',
                'Moderadamente activo',
                'Ligeramente activo',
                'Sedentario'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Nivel de Actividad',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() => _isLoading = true);
                  await fetchData(context, userData);
                  setState(() => _isLoading = false);
                }
              },
              child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData(BuildContext context, UserData userData) async {
    var url = Uri.parse('https://ag-api-4f2735c9d74e.herokuapp.com/run'); // Reemplaza con la URL de tu API
    //                  https://ag-api-4f2735c9d74e.herokuapp.com/run
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      "genero": userData.gender,
      "peso": userData.weight,
      "altura": userData.height,
      "edad": userData.age,
      "nivel_actividad": userData.activityLevel
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DietDetailsScreen(data: data)),
        );
      } else {
        _showErrorDialog(context, "Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      _showErrorDialog(context, "Error de conexión con el servidor: $e");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('¡Ha ocurrido un error!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}




/* import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dietas/screens/diet_details_screen.dart';
import 'package:dietas/user_data.dart';

class DietFormScreen extends StatefulWidget {
  @override
  _DietFormScreenState createState() => _DietFormScreenState();
}

class _DietFormScreenState extends State<DietFormScreen> {
  final _formKey = GlobalKey<FormState>();
  UserData userData = UserData(gender: 'Male', activityLevel: 'Very active'); // Valores predeterminados
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diet Input Form"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            DropdownButtonFormField(
              value: userData.gender,
              onChanged: (String? newValue) {
                setState(() {
                  userData.gender = newValue!;
                });
              },
              items: <String>['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'This field cannot be empty';
                final number = int.tryParse(value);
                if (number == null) return 'Enter a valid number';
                if (number <= 0) return 'Please enter a number greater than zero';
                return null;
              },
              onSaved: (value) {
                userData.weight = int.parse(value ?? '0');
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'This field cannot be empty';
                final number = int.tryParse(value);
                if (number == null) return 'Enter a valid number';
                if (number <= 0) return 'Please enter a number greater than zero';
                return null;
              },
              onSaved: (value) {
                userData.height = int.parse(value ?? '0');
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'This field cannot be empty';
                final number = int.tryParse(value);
                if (number == null) return 'Enter a valid number';
                if (number <= 0 || number > 120) return 'Please enter a valid age (1-120)';
                return null;
              },
              onSaved: (value) {
                userData.age = int.parse(value ?? '0');
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              value: userData.activityLevel,
              onChanged: (String? newValue) {
                setState(() {
                  userData.activityLevel = newValue!;
                });
              },
              items: <String>[
                'Very active',
                'Moderately active',
                'Lightly active',
                'Sedentary'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Activity Level',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() => _isLoading = true);
                  await fetchData(context, userData);
                  setState(() => _isLoading = false);
                }
              },
              child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData(BuildContext context, UserData userData) async {
    var url = Uri.parse('https://ag-api-4f2735c9d74e.herokuapp.com/run'); // Reemplaza con la URL de tu API
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      "gender": userData.gender,
      "weight": userData.weight,
      "height": userData.height,
      "age": userData.age,
      "activity_level": userData.activityLevel
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DietDetailsScreen(data: data)),
        );
      } else {
        _showErrorDialog(context, "Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      _showErrorDialog(context, "Failed to connect to the server: $e");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}
 */