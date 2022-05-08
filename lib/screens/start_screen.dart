import 'dart:convert';

import 'package:catalogo_filmes/utils/app_routes.dart';
import 'package:flutter/material.dart';
import '../models/movie.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          Container(padding: EdgeInsets.all(10), child: Icon(Icons.menu))
        ],
        title: Text('NerdCatalog'),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 200,
            width: 200,
            child: FloatingActionButton(
              child: Text(
                'Start Now',
                style: Theme.of(context).textTheme.headline1,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.CATALOG,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
