import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/wine_model.dart';

class WineRepository {
  Future<List<WineModel>> fetchWines() async {
    final String response = await rootBundle.loadString('assets/wine_data.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<WineModel> wines = (data['individualWines'] as List)
        .map((wine) => WineModel.fromJson(wine))
        .toList();
    return wines;
  }
}
