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
  List<Movie> _movies_list = [];

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

    // Criando Lista de objetos do tipo Movie;
    for (var element in _movies) {
      _movies_list.add(Movie.fromJson(element));
    }
    _movies_list.forEach((element) {
      print(element.title);
    });
    _movies_list.sort((a, b) => a.title!.compareTo(b.title!));
  }

  // Controle do TextField;
  final searchTextController = TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    //Dispose the controller when the screen is disposed
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          Container(padding: EdgeInsets.all(10), child: Icon(Icons.menu))
        ],
        title: const Text('Movie Catalog'),
      ),
      body: SingleChildScrollView(
        // this will make your body scrollable
        padding: const EdgeInsets.all(10),
        child: Column(
          /// your parameters
          children: <Widget>[
            Row(children: <Widget>[
              Flexible(
                child: TextField(
                  autofocus: true,
                  controller: searchTextController,
                  decoration: const InputDecoration(
                    hintText: 'Entre com o título para busca',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: 'Pesquisar Filme',
                onPressed: () {
                  setState(() {
                    searchText = searchTextController.text;
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  });
                },
              ),
            ]),
            GridView.builder(
              shrinkWrap: true,
              itemCount: _movies_list.length,
              itemBuilder: (BuildContext context, int index) =>
                  (_movies.isNotEmpty
                      ? MovieItem(_movies_list[index])
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
