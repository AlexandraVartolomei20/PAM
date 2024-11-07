import 'package:flutter/material.dart';
import 'presentation/screens/wine_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wine App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: WineListScreen(),
    );
  }
}
