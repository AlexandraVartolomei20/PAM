import 'package:get/get.dart';
import '../data_service.dart';
import '../data_service.dart';
import '../models.dart';

class NearbyCenterController extends GetxController {
  var nearbyCenters = <MedicalCenter>[].obs;
  final DataService _dataService = DataService();

  @override
  void onInit() {
    super.onInit();
    loadNearbyCenters();
  }

  void loadNearbyCenters() async {
    try {
      var centerData = await _dataService.loadNearbyCenters();
      nearbyCenters.assignAll(centerData);
    } catch (e) {
      print('Error loading nearby centers: $e');
    }
  }
}
