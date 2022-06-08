import 'dart:convert';
import 'package:catalogo_filmes/components/drawer.dart';
import 'package:catalogo_filmes/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/card_movie_item.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  State<CatalogScreen> createState() => _CatalogcreenState();
}

class _CatalogcreenState extends State<CatalogScreen> {
  List _movies = [];
  List<Movie> moviesList = [];
  List<Movie> itensFiltrados = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/movies.json');
    final data = await jsonDecode(response);
    setState(() {
      _movies = data["movies"] as List;
    });
    // Criando Lista de objetos do tipo Movie;
    for (var element in _movies) {
      moviesList.add(Movie.fromJson(element));
    }
    itensFiltrados.addAll(moviesList);

    itensFiltrados.sort((a, b) => a.title!.compareTo(b.title!));
  }

  // Controle do TextField;
  final searchTextController = TextEditingController();
  String searchText = "";
  void filtrar(String searchText) {
    itensFiltrados.clear();

    itensFiltrados.addAll(moviesList.where((element) =>
        element.title!.toLowerCase().contains(searchText.toLowerCase())));

    itensFiltrados.sort((a, b) => a.title!.compareTo(b.title!));
  }

  @override
  void dispose() {
    //Dispose the controller when the screen is disposed
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Movie Catalog'),
      ),
      drawer: const MyMainDrawer(),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          /// your parameters
          children: <Widget>[
            Row(children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 15),
                  child: TextField(
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                    cursorColor: Theme.of(context).colorScheme.tertiary,
                    controller: searchTextController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 5, top: 1),
                      hintText: 'Entre com o título para busca',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    onEditingComplete: () {
                      setState(() {
                        searchText = searchTextController.text;
                      });
                      filtrar(searchText);
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                tooltip: 'Pesquisar Filme',
                onPressed: () {
                  setState(() {
                    searchText = searchTextController.text;
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    filtrar(searchText);
                  });
                },
              ),
            ]),
            Container(
                child: Expanded(
              child: (itensFiltrados.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Text(
                        'Nenhum filme encontrado!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: itensFiltrados.length,
                      itemBuilder: (BuildContext context, int index) =>
                          CardMovieItem(itensFiltrados[index], true, true),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 2.0,
                        mainAxisExtent: 250,
                      ),
                    )),
            ))
          ],
        ),
      ),
    );
  }
}
