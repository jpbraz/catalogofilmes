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

  @override
  void dispose() {
    //Dispose the controller when the screen is disposed
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          Container(padding: EdgeInsets.all(10), child: Icon(Icons.menu))
        ],
        title: const Text('Movie Catalog'),
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
                        left: 10, right: 10, top: 10, bottom: 20),
                    child: TextField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                      cursorColor: Colors.white,
                      autofocus: true,
                      controller: searchTextController,
                      decoration: const InputDecoration(
                        hintText: 'Entre com o título para busca',
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
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
                        mainAxisExtent: 300,
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  void filtrar(String searchText) {
    _itens_filtrados.clear();

    _itens_filtrados.addAll(
        _movies_list.where((element) => element.title!.contains(searchText)));

    _itens_filtrados.sort((a, b) => a.title!.compareTo(b.title!));
  }
}
