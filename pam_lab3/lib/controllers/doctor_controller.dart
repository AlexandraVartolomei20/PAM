import 'dart:convert'; // Import for JSON decoding
import 'package:flutter/services.dart'; // Import for loading local assets
import 'package:get/get.dart';

import '../models.dart';

class DoctorController extends GetxController {
  var doctors = <DoctorModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  // Fetch the doctor data from the JSON file
  void fetchDoctors() async {
    try {
      final String response = await rootBundle.loadString('assets/v1.json');
      final Map<String, dynamic> data = json.decode(response);
      final List<dynamic> doctorList = data['doctors'];
      var doctorData = doctorList.map((json) => DoctorModel.fromJson(json)).toList();
      doctors.assignAll(doctorData);

      // Verifică dacă datele sunt corect încărcate
      print("Doctors loaded: ${doctors.length}");
    } catch (e) {
      print('Error fetching doctors: $e');
    }
  }

}
