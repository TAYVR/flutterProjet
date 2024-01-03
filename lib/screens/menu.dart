import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Recherche de photos'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/photo_search');
            },
          ),
          ListTile(
            title: Text('Liste de news'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/news_list');
            },
          ),
          ListTile(
            title: Text('calculer le jour'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/calculeJour');
            },
          ),
        ],
      ),
    );
  }
}
