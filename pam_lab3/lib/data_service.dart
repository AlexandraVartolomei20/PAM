import 'dart:convert';
import 'package:flutter/services.dart';
import 'models.dart';

class DataService {
  Future<List<BannerModel>> loadBanners() async {
    final String response = await rootBundle.loadString('assets/v1.json');
    final data = await json.decode(response);
    return (data['banners'] as List).map((i) => BannerModel.fromJson(i)).toList();
  }

  Future<List<CategoryModel>> loadCategories() async {
    final String response = await rootBundle.loadString('assets/v1.json');
    final data = await json.decode(response);
    return (data['categories'] as List).map((i) => CategoryModel.fromJson(i)).toList();
  }

  Future<List<MedicalCenter>> loadNearbyCenters() async {
    final String response = await rootBundle.loadString('assets/v1.json');
    final data = await json.decode(response);
    return (data['nearby_centers'] as List).map((i) => MedicalCenter.fromJson(i)).toList();
  }

  Future<List<DoctorModel>> loadDoctors() async {
    final String response = await rootBundle.loadString('assets/v1.json');
    final data = await json.decode(response);
    return (data['doctors'] as List).map((i) => DoctorModel.fromJson(i)).toList();
  }
}
