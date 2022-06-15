import 'package:catalogo_filmes/components/rating_form.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/favorites_provider.dart';
import '../providers/playlists_provider.dart';
import 'new_playlist.dart';

enum Options { create, addTo, rating }

class MovieMenu extends StatefulWidget {
  final Movie _movie;

  MovieMenu(this._movie);
  @override
  State<MovieMenu> createState() => _MovieMenuState();
}

class _MovieMenuState extends State<MovieMenu> {
  bool _isMovieInitialized = false;

  String dropDownValue = 'playlists';
  @override
  void initState() {
    if (!_isMovieInitialized) {
      Provider.of<PlayLists>(context, listen: false).fetchPlaylists().then((_) {
        setState(() {
          _isMovieInitialized = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var favorites = context.watch<Favorites>();
    var playlists = context.watch<PlayLists>();

    if (playlists.listOfPlayLists.isNotEmpty && dropDownValue == 'playlists') {
      dropDownValue = playlists.listOfPlayLists.values.first.id;
    }

    _hasMovie(Movie movie) {
      final result = favorites.favoriteMovies
          .where((element) => element.id == movie.id)
          .toList();

      return result.isNotEmpty;
    }

    return Expanded(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  opacity: 20,
                  image: NetworkImage(widget._movie.imageUrl),
                  fit: BoxFit.fill),
            ),
          ),
          Positioned(
            child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.black87,
                child: Text(
                  widget._movie.title,
                  style: Theme.of(context).textTheme.headline2,
                )),
            bottom: 10,
            left: 40,
            right: 3,
          ),
          Positioned(
            child: Container(
              color: Colors.black45,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
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
                    icon: _hasMovie(widget._movie)
                        ? Icon(Icons.favorite, color: Colors.red[800], size: 30)
                        : const Icon(
                            Icons.favorite_border,
                            size: 30,
                          ),
                    onPressed: () {
                      setState(() {
                        if (_hasMovie(widget._movie)) {
                          favorites.removeFavoriteMovie(widget._movie);
                        } else {
                          favorites.addFavoriteMovie(widget._movie);
                        }
                      });
                    },
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: Text('Create Playlist'),
                        value: Options.create,
                      ),
                      const PopupMenuItem(
                        child: Text('Add to playlist'),
                        value: Options.addTo,
                      ),
                      const PopupMenuItem(
                        child: Text('Rating'),
                        value: Options.rating,
                      ),
                    ],
                    onSelected: (option) {
                      if (option == Options.create) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => NewPlaylist());
                      } else if (option == Options.rating) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => RatingForm(
                                  movie: widget._movie,
                                ));
                      } else if (option == Options.addTo) {
                        if (playlists.listOfPlayLists.isNotEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                              builder: ((context, setState) => AlertDialog(
                                    title: const Text('Choose the playlist'),
                                    content: DropdownButton(
                                        value: dropDownValue,
                                        items: playlists.listOfPlayLists.values
                                            .map((playlist) => DropdownMenuItem(
                                                  child: Text(playlist.name
                                                      .toUpperCase()),
                                                  value: playlist.id,
                                                ))
                                            .toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropDownValue = newValue!;
                                          });
                                        }),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              await playlists.saveToPlaylist(
                                                  dropDownValue, widget._movie);
                                            } catch (error) {
                                              await showDialog<Null>(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                        title: const Text(
                                                            'An error occurred!'),
                                                        content: const Text(
                                                            'Something went wrong.'),
                                                        actions: [
                                                          ElevatedButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              child: const Text(
                                                                  'Close'))
                                                        ],
                                                      ));
                                            } finally {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Text('Confirm'))
                                    ],
                                  )),
                            ),
                          );
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
    );
  }
}
