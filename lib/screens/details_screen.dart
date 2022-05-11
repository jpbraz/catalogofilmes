import 'package:catalogo_filmes/models/favorites.dart';
import 'package:flutter/material.dart';
import 'package:catalogo_filmes/models/movie.dart';
import 'package:catalogo_filmes/models/genre.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List _items = [];
  List _genreList = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/my_genre_data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["genres"];
      for (var genre in _items) {
        _genreList.add(genre);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)?.settings.arguments as Movie;
    String movieTitle = movie.title as String;
    String posterPath = movie.posterPath as String;
    String releaseDate = movie.releaseDate as String;
    String ano = releaseDate.substring(0, 4);
    String overview = movie.overview as String;
    num? rate = movie.voteAverage;
    List<int> genres = movie.genreIds!;
    int percentual = (rate! * 10).toInt();
    List<String> genresNames = [];

    bool isFavorite = false;

    setState(() {
      for (var movieGenre in genres) {
        for (var genre in _genreList) {
          if (movieGenre == genre['id']) {
            genresNames.add(genre['name']);
          }
        }
      }
    });

    _favoriteHanler() {
      setState(() {});
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 480,
            flexibleSpace: Stack(children: [
              FlexibleSpaceBar(
                background: Image.network(
                  'https://image.tmdb.org/t/p/w220_and_h330_face$posterPath',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  right: 20,
                  top: 45,
                  child: Consumer<Favorites>(builder: (context, icon, child) {
                    isFavorite = icon.favoriteMovies.contains(movie);
                    return (isFavorite
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorite = false;
                                icon.removeFavoriteMovie(movie);
                              });
                            },
                            child: Icon(
                              Icons.check,
                              size: 60,
                              color: Colors.green[600],
                              semanticLabel: 'Added as favorite',
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorite = true;
                                icon.addFavoriteMovie(movie);
                              });
                            },
                            child: Icon(
                              Icons.favorite_sharp,
                              size: 60,
                              color: Colors.red[600],
                              semanticLabel: 'Add as favorite',
                            ),
                          ));
                  }))
            ]),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
                margin: const EdgeInsets.only(bottom: 3, top: 10),
                child: Row(
                  children: [
                    Text("Ano de Lançamento - ",
                        style: Theme.of(context).textTheme.headline2),
                    Text(ano,
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.tertiary))
                  ],
                )),
            Container(
                margin: const EdgeInsets.all(3),
                child: Row(
                  children: [
                    Text("Gênero: ",
                        style: Theme.of(context).textTheme.headline2),
                    Container(
                      height: 40,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: genresNames.length,
                          itemBuilder: (context, index) => Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      genresNames[index],
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                    )
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Text("Sinopse: ",
                  style: Theme.of(context).textTheme.headline2),
            ),
            Container(
                height: 95,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListView(
                  children: [
                    Text(overview,
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.tertiary)),
                  ],
                )),
            Container(
                margin: const EdgeInsets.all(3),
                child: Row(
                  children: [
                    Text("Rating: ",
                        style: Theme.of(context).textTheme.headline2),
                    Text(rate.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.tertiary))
                  ],
                )),
          ]))
        ]));
  }
}
