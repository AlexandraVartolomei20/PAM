import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data_service.dart';
import '../models.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  final DataService _dataService = DataService();

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() async {
    try {
      var categoryData = await _dataService.loadCategories();
      categories.assignAll(categoryData);
      print('Categories loaded: ${categories.length}'); // Check if data is loaded
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

}
