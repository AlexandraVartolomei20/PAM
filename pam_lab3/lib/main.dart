import 'package:flutter/material.dart';
import 'pages/banner_page.dart'; // Importă pagina ta principală

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pam Lab 3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BannerPage(), // Aici poți seta pagina principală
    );
  }
}
