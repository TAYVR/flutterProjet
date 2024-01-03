import 'package:flutter/material.dart';
import 'package:my_app/screens/menu.dart';
import 'package:numberpicker/numberpicker.dart';

class DateCalculationPage extends StatefulWidget {
  @override
  _DateCalculationPageState createState() => _DateCalculationPageState();
}

class _DateCalculationPageState extends State<DateCalculationPage> {
  String _result = '';
  var day = 1;
  var month = 1;
  var year = 1990;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcul du jour'),
      ),
      drawer: MenuScreen(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              NumberPicker(
                value: day,
                minValue: 1,
                maxValue: 31,
                onChanged: (value) => setState(() => day = value),
              ),
              NumberPicker(
                value: month,
                minValue: 1,
                maxValue: 12,
                onChanged: (value) => setState(() => month = value),
              ),
              NumberPicker(
                value: year,
                minValue: 1990,
                maxValue: 2024,
                onChanged: (value) => setState(() => year = value),
              ),
            ]),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateDay();
              },
              child: Text('Calculer'),
            ),
            SizedBox(height: 20),
            Text('Résultat : $_result'),
          ],
        ),
      ),
    );
  }

  void calculateDay() {
   
      int f = [0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5][month - 1];

      int result = (day + (year - 1900) + ((year - 1900) ~/ 4) + f) % 7;

      // Map the result to the corresponding day of the week
      List<String> daysOfWeek = [
        'Dimanche',
        'Lundi',
        'Mardi',
        'Mercredi',
        'Jeudi',
        'Vendredi',
        'Samedi'
      ];

      setState(() {
        _result = daysOfWeek[result-1];
      });
   
  }
}
