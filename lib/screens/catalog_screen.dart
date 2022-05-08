import 'dart:convert';
import 'package:catalogo_filmes/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/movie_item.dart';

class CatalogScreen extends StatefulWidget {
  @override
  State<CatalogScreen> createState() => _CatalogcreenState();
}

class _CatalogcreenState extends State<CatalogScreen> {
  List _movies = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/movies.json');
    final data = await jsonDecode(response);
    setState(() {
      _movies = data["movies"] as List;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          Container(padding: EdgeInsets.all(10), child: Icon(Icons.menu))
        ],
        title: Text('Movie Catalog'),
      ),
      body: CustomScrollView(slivers: [
        SliverGrid(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          delegate: SliverChildBuilderDelegate((context, index) =>
              (_movies.length > 0
                  ? MovieItem(Movie.fromJson(_movies[index]))
                  : Text('Nenhum filme encontrado!'))),
        ),
      ]),
    );
  }
}
