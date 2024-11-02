import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/banner_controller.dart';
import '../controllers/category_controller.dart';
import '../controllers/nearby_center_controller.dart';
import '../controllers/doctor_controller.dart';
import '../models.dart';
import '../doctor_list_page.dart'; // Import the DoctorsListPage

class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  final BannerController bannerController = Get.put(BannerController());
  final CategoryController categoryController = Get.put(CategoryController());
  final NearbyCenterController nearbyCenterController = Get.put(NearbyCenterController());
  final DoctorController doctorController = Get.put(DoctorController());

  final TextEditingController searchController = TextEditingController();
  bool isCityListExpanded = false;
  bool isSeeAll = false;
  String selectedCity = 'Seattle, USA';
  final List<String> locations = ['Seattle, USA', 'New York, USA', 'Los Angeles, USA'];

  final List<Color> categoryColors = [
    Color(0xFFF48FB1),
    Color(0xFFA5D6A7),
    Color(0xFFFF8A65),
    Color(0xFFB39DDB),
    Color(0xFF4A148C),
    Colors.teal,
    Color(0xFF4DD0E1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location',
                    style: TextStyle(fontSize: 18, color: Colors.black38),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCityListExpanded = !isCityListExpanded;
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_rounded, color: Colors.black),
                        const SizedBox(width: 8),
                        Text(
                          selectedCity,
                          style: const TextStyle(fontSize: 20, color: Colors.black87),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isCityListExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.black54),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (query) {
                          bannerController.filterBanners(query);
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search doctor...',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Banners Carousel
            Container(
              height: 200,
              child: Obx(() {
                if (bannerController.filteredBanners.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bannerController.filteredBanners.length,
                  itemBuilder: (context, index) {
                    var banner = bannerController.filteredBanners[index];
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(banner.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Positioned(
                            bottom: 80,
                            left: 10,
                            child: Text(
                              banner.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            left: 10,
                            child: Text(
                              banner.description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),

            // Categories Section
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSeeAll = !isSeeAll;
                      });
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(fontSize: 20, color: Colors.black38),
                    ),
                  ),
                ],
              ),
            ),

            // Displaying Categories
            Obx(() {
              int itemCount = isSeeAll ? categoryController.categories.length : 4;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemCount,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        var category = categoryController.categories[index];
                        return Column(
                          children: [
                            Container(
                              width: 65,
                              height: 60,
                              decoration: BoxDecoration(
                                color: categoryColors[index % categoryColors.length],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.network(
                                  category.icon,
                                  color: Colors.white,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              category.title,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }),

            // Nearby Medical Centers Section
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nearby Medical Centers',
                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add functionality for 'See All'
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(fontSize: 20, color: Colors.black38),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Nearby Medical Centers Carousel
            Container(
              height: 330,
              child: Obx(() {
                if (nearbyCenterController.nearbyCenters.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: nearbyCenterController.nearbyCenters.length,
                  itemBuilder: (context, index) {
                    var center = nearbyCenterController.nearbyCenters[index];
                    return _buildMedicalCenterCard(center);
                  },
                );
              }),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),

            // Doctors Section Button
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Doctors',
                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DoctorsListPage());
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(fontSize: 20, color: Colors.black38),
                    ),
                  ),
                ],
              ),
            ),

            // Doctors List
            Container(
              height: 300,
              child: Obx(() {
                if (doctorController.doctors.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: doctorController.doctors.length,
                  itemBuilder: (context, index) {
                    var doctor = doctorController.doctors[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                doctor.image ?? 'https://via.placeholder.com/150',
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                                alignment: Alignment(0.5, 0.3),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        doctor.fullName ?? 'Unknown',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.favorite_border,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  const Divider(color: Colors.black),
                                  Text(
                                    doctor.typeOfDoctor ?? 'Specialty Unknown',
                                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.black45,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        doctor.locationOfCenter ?? 'Location Unknown',
                                        style: const TextStyle(fontSize: 14, color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${doctor.reviewRate ?? 'No Rating'}',
                                        style: const TextStyle(fontSize: 14, color: Colors.black45),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${doctor.reviewsCount ?? 'No Reviews'} Reviews',
                                        style: const TextStyle(fontSize: 14, color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Medical Center Card Builder
  Widget _buildMedicalCenterCard(MedicalCenter center) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              center.image,
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  center.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(center.locationName, style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text('${center.reviewRate} (${center.countReviews} Reviews)'),
                  ],
                ),
                const SizedBox(height: 5),
                Text('${center.distanceKm} km / ${center.distanceMinutes} min'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
