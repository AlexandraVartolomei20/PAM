import 'package:get/get.dart';
import '../data_service.dart';
import '../models.dart';

class BannerController extends GetxController {
  var banners = <BannerModel>[].obs;
  var filteredBanners = <BannerModel>[].obs;
  final DataService _dataService = DataService();

  @override
  void onInit() {
    super.onInit();
    loadBanners();
  }

  void loadBanners() async {
    var bannerData = await _dataService.loadBanners();
    banners.assignAll(bannerData);
    filteredBanners.assignAll(bannerData); // Initially, filtered and banners are the same
  }

  void filterBanners(String query) {
    if (query.isEmpty) {
      filteredBanners.assignAll(banners);
    } else {
      var filtered = banners
          .where((banner) =>
      banner.title.toLowerCase().contains(query.toLowerCase()) ||
          banner.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredBanners.assignAll(filtered);
    }
  }
}
