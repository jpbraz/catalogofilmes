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
      body: SingleChildScrollView(
        // this will make your body scrollable
        padding: const EdgeInsets.all(10),
        child: Column(
          /// your parameters
          children: <Widget>[
            GridView.builder(
              shrinkWrap: true,
              itemCount: _movies.length,
              itemBuilder: (BuildContext context, int index) =>
                  (_movies.isNotEmpty
                      ? MovieItem(
                          Movie.fromJson(_movies[index]),
                        )
                      : const Text('Nenhum filme encontrado!')),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
