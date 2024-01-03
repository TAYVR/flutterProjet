import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/screens/menu.dart';

class PhotoSearchScreen extends StatefulWidget {
  @override
  _PhotoSearchScreenState createState() => _PhotoSearchScreenState();
}

class _PhotoSearchScreenState extends State<PhotoSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _photos = [];
  int _page = 1;

  Future<void> _searchPhotos(String query, int page) async {
    final String apiKey = "Nrn9joRPR3eXhticZXnrIFTV_clUoAownkEvEB_8k78";
    final String apiUrl =
        "https://api.unsplash.com/search/photos/?client_id=$apiKey&query=$query&page=$page";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        _photos = json.decode(response.body)['results'];
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recherche de photos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue, // Change the background color of the app bar
      ),
      drawer: MenuScreen(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Entrez votre recherche',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _searchPhotos(_searchController.text, _page);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _photos.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        _photos[index]['alt_description'] ?? 'No description',
                        style: TextStyle(
                          color: Colors.blue, // Change the title color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Image.network(_photos[index]['urls']['small']),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_page > 1) {
                      setState(() {
                        _page--;
                      });
                      _searchPhotos(_searchController.text, _page);
                    }
                  },
                  child: Text('Précédent'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _page++;
                    });
                    _searchPhotos(_searchController.text, _page);
                  },
                  child: Text('Suivant'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
