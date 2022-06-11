import 'package:catalogo_filmes/components/new_playlist.dart';
import 'package:catalogo_filmes/models/playlist.dart';
import 'package:catalogo_filmes/providers/favorites_provider.dart';
import 'package:catalogo_filmes/providers/playlists_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

enum Options { create, addTo }

class DetailsScreen extends StatefulWidget {
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final Movie _movie;
  bool _isMovieInitialized = false;
  String dropDownValue = 'playlists';
  @override
  Widget build(BuildContext context) {
    if (!_isMovieInitialized) {
      setState(() {
        _movie = ModalRoute.of(context)!.settings.arguments as Movie;
        _isMovieInitialized = true;
      });
    }
    var favorites = context.watch<Favorites>();
    var playlists = context.watch<PlayLists>();
    if (playlists.listOfPlayLists.isNotEmpty) {
      dropDownValue = playlists.listOfPlayLists.values.first.id;
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        opacity: 20,
                        image: NetworkImage(_movie.imageUrl),
                        fit: BoxFit.fill),
                  ),
                ),
                Positioned(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.black87,
                      child: Text(
                        _movie.title,
                        style: Theme.of(context).textTheme.headline2,
                      )),
                  bottom: 10,
                  left: 40,
                  right: 3,
                ),
                Positioned(
                  child: Container(
                    color: Colors.black45,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 30,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: favorites.favoriteMovies.contains(_movie)
                              ? Icon(Icons.favorite,
                                  color: Colors.red[800], size: 30)
                              : const Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                ),
                          onPressed: () {
                            setState(() {
                              if (favorites.favoriteMovies.contains(_movie)) {
                                favorites.removeFavoriteMovie(_movie);
                              } else {
                                favorites.addFavoriteMovie(_movie);
                              }
                            });
                          },
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('Create Playlist'),
                              value: Options.create,
                            ),
                            PopupMenuItem(
                              child: Text('Add to playlist'),
                              value: Options.addTo,
                            ),
                          ],
                          onSelected: (option) {
                            if (option == Options.create) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => NewPlaylist());
                            } else if (option == Options.addTo) {
                              if (playlists.listOfPlayLists.isNotEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                        builder: ((context, setState) =>
                                            AlertDialog(
                                              title:
                                                  Text('Choose the playlist'),
                                              content: DropdownButton(
                                                  value: dropDownValue,
                                                  items: playlists
                                                      .listOfPlayLists.values
                                                      .map((playlist) =>
                                                          DropdownMenuItem(
                                                            child: Text(playlist
                                                                .name
                                                                .toUpperCase()),
                                                            value: playlist.id,
                                                          ))
                                                      .toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      dropDownValue = newValue!;
                                                    });
                                                  }),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      //TODO: adicionar ao banco
                                                      playlists.listOfPlayLists
                                                          .entries
                                                          .firstWhere(
                                                              (playlist) =>
                                                                  playlist.value
                                                                      .id ==
                                                                  dropDownValue)
                                                          .value
                                                          .addMovieToList(
                                                              _movie);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child:
                                                        const Text('Confirmar'))
                                              ],
                                            ))));
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  top: 0,
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            color: Theme.of(context).colorScheme.primary,
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Título Completo: ${_movie.title}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Ano: ${_movie.year}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Diretores: ${_movie.directors}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Elenco: ${_movie.crew}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nota IMDb: ${_movie.rate}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sinopse: ${_movie.plot}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
