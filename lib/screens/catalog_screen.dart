import 'dart:convert';
import 'package:catalogo_filmes/models/movie.dart';
import 'package:catalogo_filmes/utils/app_routes.dart';
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
  List<Movie> _itens_filtrados = [];

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
    _itens_filtrados.addAll(_movies_list);

    _itens_filtrados.sort((a, b) => a.title!.compareTo(b.title!));
  }

  // Controle do TextField;
  final searchTextController = TextEditingController();
  String searchText = "";
  void filtrar(String searchText) {
    _itens_filtrados.clear();

    _itens_filtrados.addAll(_movies_list.where((element) =>
        element.title!.toLowerCase().contains(searchText.toLowerCase())));

    _itens_filtrados.sort((a, b) => a.title!.compareTo(b.title!));
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
      drawer: Drawer(
        child: Container(
          alignment: Alignment.center,
          color: Theme.of(context).colorScheme.primary,
          height: 100,
          padding: EdgeInsets.only(top: 60),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'NerdCatalog',
                  style: TextStyle(
                      fontSize: 40,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.CATALOG);
              },
              child: Container(
                margin: EdgeInsets.only(top: 60, left: 60),
                width: 200,
                child: Row(
                  children: [
                    Icon(Icons.book_rounded),
                    Text(
                      'Catalog',
                      style: TextStyle(
                          fontSize: 27,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (() {
                Navigator.of(context).pushNamed(AppRoutes.FAVORITES);
              }),
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 60),
                width: 200,
                child: Row(
                  children: [
                    Icon(Icons.favorite),
                    Text(
                      'Favorites',
                      style: TextStyle(
                          fontSize: 27,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: SingleChildScrollView(
          // this will make your body scrollable
          padding: const EdgeInsets.all(10),
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
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
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
              (_itens_filtrados.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        'Nenhum filme encontrado!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: _itens_filtrados.length,
                      itemBuilder: (BuildContext context, int index) =>
                          MovieItem(_itens_filtrados[index]),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 2.0,
                        mainAxisExtent: 250,
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
