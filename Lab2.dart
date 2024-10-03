import 'package:flutter/material.dart';

void main() {
  runApp(DrinkStoreApp());
}

class DrinkStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrinkStoreAppBar(),
    );
  }
}

class DrinkStoreAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blueAccent),
                SizedBox(width: 5),
                Text(
                  'Donnerville Drive',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.black)
              ],
            ),
            Text(
              '4 Donnerville Hall, Donnerville Drive, Admaston...',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '12',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          SizedBox(height: 20),
          _buildWineSectionTitle(), // Titlul pentru secțiunea cu vinuri
          SizedBox(height: 10),
          _buildWineCategories(), // Categoriile de vinuri
          SizedBox(height: 20),
          _buildSectionTitle(), // Titlul "Wine" și "view all"
          SizedBox(height: 10),
          _buildDetailedWineCard('Ocone Bozzovich Beneventano Bianco IGT', '₹ 23,256,596', 'assets/images3.jpg', true),
          SizedBox(height: 10),
          _buildDetailedWineCard('2021 Petit Chablis-Passy Le Clou', '₹ 23,256,596', 'assets/images4.jpg', false),
          SizedBox(height: 10),
          _buildDetailedWineCard('Philippe Fontaine Champagne Brut Rose, Rose de Saignee, NV', '₹ 23,256,596', 'assets/images7.png', true),
          SizedBox(height: 10),
          _buildDetailedWineCard('2021 Cicada Song Rose', '₹ 23,256,596', 'assets/images8.png', true),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.mic, color: Colors.grey),
        ],
      ),
    );
  }

  // Secțiunea "Shop Wine by"
  Widget _buildWineSectionTitle() {
    return Text(
      'Shop Wine by',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  // Titlul "Wine" și "view all"
  Widget _buildSectionTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Wine',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'view all',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildWineCategories() {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildWineCard('Red wines', '123', 'assets/images1.jpg'),
          SizedBox(width: 10),
          _buildWineCard('White wines', '123', 'assets/images2.jpg'),
          SizedBox(width: 10),
          _buildWineCard('Rosé wines', '123', 'assets/images1.jpg'),
          SizedBox(width: 10),
          _buildWineCard('White wines', '123', 'assets/images2.jpg'),
          SizedBox(width: 10),
          _buildWineCard('Rosé wines', '123', 'assets/images1.jpg'),
        ],
      ),
    );
  }

  Widget _buildWineCard(String wineType, String count, String imagePath) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              height: 80,
            ),
          ),
          Text(wineType, style: TextStyle(fontWeight: FontWeight.bold)),
          Text('$count products', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  // Cardul detaliat pentru vinuri
  Widget _buildDetailedWineCard(String title, String price, String imagePath, bool isAvailable) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                isAvailable ? 'Available' : 'Unavailable',
                style: TextStyle(
                  color: isAvailable ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Image.asset(
                imagePath,
                height: 120,
                width: 80,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images5.jpg',
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(width: 4),
                        Text('Red wine (Green and Flinty)'),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images6.png',
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(width: 5),
                        Text('From Champagne Blanc, France'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      icon: Icon(isAvailable ? Icons.favorite_border : Icons.favorite_border),
                      label: Text(isAvailable ? 'Favourite' : 'Added', style: TextStyle(color: Colors.black )),
                      onPressed: () {},
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Critics\' Scores: ${isAvailable ? '94 / 100' : '94 / 100'}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      isAvailable ? 'Bottle (750ml)' : 'Bottle (750ml)',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
