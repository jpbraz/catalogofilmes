import 'package:catalogo_filmes/components/new_playlist.dart';
import 'package:catalogo_filmes/models/playlist.dart';
import 'package:catalogo_filmes/providers/favorites_provider.dart';
import 'package:catalogo_filmes/providers/playlists_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/rating_form.dart';
import '../models/movie.dart';
import '../models/rating.dart';
import '../controller/firebaseController.dart';

enum Options { create, addTo, rating }

class DetailsScreen extends StatefulWidget {
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final Movie _movie;
  bool _isMovieInitialized = false;
  bool _isLoading = false;
  late List<Rating> ratings;

  String dropDownValue = 'playlists';

  @override
  void initState() {
    _isLoading = true;
    ratings = [];

    if (!_isMovieInitialized) {
      Provider.of<PlayLists>(context, listen: false).fetchPlaylists().then((_) {
        setState(() {
          _isLoading = false;
          _isMovieInitialized = true;
        });
      });
    }
  }

  void getRating(Movie movie) async {
    List<Rating> aux =
        await FirebaseController().getRatingsInFirebaseByMovie(movie);
    setState(() {
      ratings = aux;
    });
  }

  void deleteRating(String id) async {
    await FirebaseController().deleteRatingInFirebase(id);
    setState(() {
      ratings;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isMovieInitialized) {
      setState(() {
        _movie = ModalRoute.of(context)!.settings.arguments as Movie;
        _isMovieInitialized = true;
      });
    }
    getRating(_movie);
    var favorites = context.watch<Favorites>();
    var playlists = context.watch<PlayLists>();
    if (playlists.listOfPlayLists.isNotEmpty) {
      dropDownValue = playlists.listOfPlayLists.values.first.id;
    }

    _hasMovie(Movie movie) {
      final result = favorites.favoriteMovies
          .where((element) => element.id == movie.id)
          .toList();

      return result.isNotEmpty;
    }

    return SafeArea(
      child: Scaffold(
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
                            icon: _hasMovie(_movie)
                                ? Icon(Icons.favorite,
                                    color: Colors.red[800], size: 30)
                                : const Icon(
                                    Icons.favorite_border,
                                    size: 30,
                                  ),
                            onPressed: () {
                              setState(() {
                                if (_hasMovie(_movie)) {
                                  favorites.removeFavoriteMovie(_movie);
                                } else {
                                  favorites.addFavoriteMovie(_movie);
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
                                          movie: _movie,
                                        ));
                              } else if (option == Options.addTo) {
                                if (playlists.listOfPlayLists.isNotEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                      builder: ((context, setState) =>
                                          AlertDialog(
                                            title: const Text(
                                                'Choose the playlist'),
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
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    dropDownValue = newValue!;
                                                  });
                                                }),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    try {
                                                      await playlists
                                                          .saveToPlaylist(
                                                              dropDownValue,
                                                              _movie);
                                                    } catch (error) {
                                                      await showDialog<Null>(
                                                          context: context,
                                                          builder:
                                                              (ctx) =>
                                                                  AlertDialog(
                                                                    title: const Text(
                                                                        'An error occurred!'),
                                                                    content:
                                                                        const Text(
                                                                            'Something went wrong.'),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                          onPressed: () => Navigator.of(context)
                                                                              .pop(),
                                                                          child:
                                                                              const Text('Close'))
                                                                    ],
                                                                  ));
                                                    } finally {
                                                      Navigator.of(context)
                                                          .pop();
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
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              color: Theme.of(context).colorScheme.primary,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Title: ${_movie.title}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Year: ${_movie.year}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Directors: ${_movie.directors}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Cast: ${_movie.crew}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'IMDb rate: ${_movie.rate}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Plot: ${_movie.plot}',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Commentaries: ",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            WidgetSpan(
                              child: IconButton(
                                icon: const Icon(Icons.add, size: 20),
                                padding:
                                    const EdgeInsets.only(left: 200, top: 25),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => RatingForm(
                                            movie: _movie,
                                          ));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ListView.builder(
                            itemCount: ratings.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Rating currentItem = ratings[index];
                              return Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "${currentItem.value.toString()} - \"${currentItem.comment}\"",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  )),
                                  const SizedBox(
                                    width: 50,
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      icon: const Icon(Icons.edit, size: 20),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => RatingForm(
                                                  movie: _movie,
                                                  rating: currentItem,
                                                ));
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      icon: const Icon(Icons.delete, size: 20),
                                      onPressed: () {
                                        deleteRating(currentItem.id);
                                      },
                                    ),
                                  )
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
