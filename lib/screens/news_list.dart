import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/screens/menu.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _news = [];

  Future<void> _fetchNews(String query) async {
    final String apiKey = "e8275d0e4acf4f5c83f35081aba1c517";
    final String apiUrl =
        "https://newsapi.org/v2/everything?q=$query&sortBy=popularity&apiKey=$apiKey";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        _news = json.decode(response.body)['articles'];
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste de news',
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
                      _fetchNews(_searchController.text);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _news.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        _news[index]['title'] ?? 'No title',
                        style: TextStyle(
                          color: Colors.blue, // Change the title color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _news[index]['description'] ?? 'No description',
                        style: TextStyle(color: Colors.black54), // Change the description color
                      ),
                      
                      
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
