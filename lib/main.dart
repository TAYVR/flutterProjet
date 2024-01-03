import 'package:flutter/material.dart';
import 'package:my_app/screens/calculeJour.dart';
import 'screens/photo_search.dart';
import 'screens/news_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'projet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PhotoSearchScreen(),
        '/photo_search': (context) => PhotoSearchScreen(),
        '/news_list': (context) => NewsListScreen(),
        '/calculeJour': (context) => DateCalculationPage(),
      },
    );
  }
}
