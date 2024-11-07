import 'package:flutter/material.dart';
import '../../data/repositories/wine_repository.dart';
import '../../domain/entities/wine_entity.dart';
import '../../domain/usecases/get_wines.dart';
import '../widgets/wine_card.dart';

class WineListScreen extends StatefulWidget {
  @override
  _WineListScreenState createState() => _WineListScreenState();
}

class _WineListScreenState extends State<WineListScreen> {
  late Future<List<WineEntity>> wines;
  String userLocation = "Donnerville Drive"; // Setează locația utilizatorului
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    final repository = WineRepository();
    final getWines = GetWines(repository);
    wines = getWines.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drink Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: WineSearchDelegate(wines));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<WineEntity>>(
        future: wines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final wineList = snapshot.data ?? []; // Folosește o listă goală în loc de null
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserLocation(), // Afișează locația utilizatorului
              _buildSearchBar(), // Afișează bara de căutare
              _buildShopWineByTitle(), // Afișează titlul pentru "Shop Wine By"
              _buildWineCategories(), // Afișează categoriile de vinuri
              _buildWinesTitle(), // Afișează titlul pentru "Wines" aici
              Expanded(
                child: ListView.builder(
                  itemCount: wineList.length,
                  itemBuilder: (context, index) {
                    return WineCard(wine: wineList[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserLocation() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.blueAccent),
          SizedBox(width: 5),
          Text(
            userLocation,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value; // Actualizează interogarea de căutare
          });
        },
        decoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), // Colțuri rotunjite
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0), // Padding pentru text
        ),
      ),
    );
  }

  Widget _buildShopWineByTitle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Shop Wine By',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildWinesTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        'Wines', // Cuvântul "Wines" adăugat aici
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildWineCategories() {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildWineCard('Red Wines', '123', 'assets/images1.jpg'),
          SizedBox(width: 12),
          _buildWineCard('White Wines', '123', 'assets/images2.jpg'),
          SizedBox(width: 12),
          _buildWineCard('Rosé Wines', '123', 'assets/images1.jpg'),
          SizedBox(width: 12),
          _buildWineCard('Sparkling Wines', '123', 'assets/images2.jpg'), // Categorie păstrată
        ],
      ),
    );
  }

  Widget _buildWineCard(String title, String price, String imagePath) {
    return Card(
      child: Container(
        width: 140,
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 90,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(title),
            Text(price),
          ],
        ),
      ),
    );
  }

  Widget _buildWineCarousel(List<WineEntity> wineList) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: wineList.length < 3 ? wineList.length : 3, // Limita caruselul la 3 vinuri
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              width: 150,
              child: Column(
                children: [
                  Image.asset(
                    wineList[index].imagePath, // Asigură-te că `imagePath` există în entity
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Text(wineList[index].title),
                  Text(wineList[index].price),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Delegate pentru căutare
class WineSearchDelegate extends SearchDelegate<String> {
  final Future<List<WineEntity>> winesFuture;

  WineSearchDelegate(this.winesFuture);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildWineList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildWineList();
  }

  Widget _buildWineList() {
    return FutureBuilder<List<WineEntity>>(
      future: winesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final wineList = snapshot.data ?? []; // Folosește o listă goală în loc de null
        final suggestions = wineList.where((wine) {
          return wine.title.toLowerCase().contains(query.toLowerCase());
        }).toList();

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(suggestions[index].title),
              subtitle: Text(suggestions[index].price),
              onTap: () {
                close(context, suggestions[index].title);
              },
            );
          },
        );
      },
    );
  }
}
