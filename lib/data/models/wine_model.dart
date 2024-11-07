import 'dart:convert';

class WineModel {
  final String title;
  final String price;
  final String imagePath;
  final bool availability;
  final String wineType;
  final String origin;
  final String criticsScore;
  final String bottleSize;

  WineModel({
    required this.title,
    required this.price,
    required this.imagePath,
    required this.availability,
    required this.wineType,
    required this.origin,
    required this.criticsScore,
    required this.bottleSize,
  });

  factory WineModel.fromJson(Map<String, dynamic> json) {
    return WineModel(
      title: json['title'],
      price: json['price'],
      imagePath: json['imagePath'],
      availability: json['availability'],
      wineType: json['wineType'],
      origin: json['origin'],
      criticsScore: json['criticsScore'],
      bottleSize: json['bottleSize'],
    );
  }
}
