import 'package:flutter/material.dart';
import '../../domain/entities/wine_entity.dart';

class WineCard extends StatelessWidget {
  final WineEntity wine;

  const WineCard({Key? key, required this.wine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(wine.imagePath),
        title: Text(wine.title),
        subtitle: Text('Price: ${wine.price}\nOrigin: ${wine.origin}'),
        trailing: Text(wine.availability ? 'Available' : 'Not Available'),
      ),
    );
  }
}
