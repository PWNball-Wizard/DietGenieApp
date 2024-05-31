import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DietDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  DietDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de la Dieta"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("TDEE Inicial: ${data['tdee_inicial'].toStringAsFixed(2)} kcal"),
                  Text("TDEE de la Dieta: ${data['tdee_dieta'].toStringAsFixed(2)} kcal"),
                  Text("Calorías Totales: ${data['detalles_dieta']['calorias_totales'].toStringAsFixed(2)} kcal"),
                  Text("Carbohidratos: ${data['detalles_dieta']['porcentaje_carbohidratos'].toStringAsFixed(2)}%"),
                  Text("Proteínas: ${data['detalles_dieta']['porcentaje_proteinas'].toStringAsFixed(2)}%"),
                  Text("Grasas: ${data['detalles_dieta']['porcentaje_grasas'].toStringAsFixed(2)}%"),
                  SizedBox(height: 20),
                  Text("Desglose de la Dieta", style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data['dieta'].length,
              itemBuilder: (context, index) {
                var alimento = data['dieta'][index];
                return ListTile(
                  title: Text(alimento['Alimento']),
                  subtitle: Text("Carbohidratos: ${alimento['Carbohidratos']}g, "
                                 "Grasas: ${alimento['Grasas']}g, "
                                 "Proteínas: ${alimento['Proteinas']}g"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DietDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  DietDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diet Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Initial TDEE: ${data['initial_tdee'].toStringAsFixed(2)} kcal"),
                  Text("Diet TDEE: ${data['diet_tdee'].toStringAsFixed(2)} kcal"),
                  Text("Total Calories: ${data['diet_details']['total_calories'].toStringAsFixed(2)} kcal"),
                  Text("Carbohydrates: ${data['diet_details']['percent_carbs'].toStringAsFixed(2)}%"),
                  Text("Proteins: ${data['diet_details']['percent_proteins'].toStringAsFixed(2)}%"),
                  Text("Fats: ${data['diet_details']['percent_fats'].toStringAsFixed(2)}%"),
                  SizedBox(height: 20),
                  Text("Diet Breakdown", style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data['diet'].length,
              itemBuilder: (context, index) {
                var foodItem = data['diet'][index];
                return ListTile(
                  title: Text(foodItem['Food']),
                  subtitle: Text("Carbs: ${foodItem['Carbs']}g, "
                                 "Fat: ${foodItem['Fat']}g, "
                                 "Protein: ${foodItem['Protein']}g"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
 */