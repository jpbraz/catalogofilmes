import 'package:catalogo_filmes/providers/playlists_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/movie_items/movie_info.dart';
import '../components/movie_items/movie_menu.dart';

import '../models/movie.dart';

class DetailsScreen extends StatelessWidget {
  late final Movie _movie;
  bool _isMovieInitialized = false;

  @override
  Widget build(BuildContext context) {
    if (!_isMovieInitialized) {
      _movie = ModalRoute.of(context)!.settings.arguments as Movie;
      Provider.of<PlayLists>(context, listen: false).fetchPlaylists().then((_) {
        _isMovieInitialized = true;
      });
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
          
            Expanded(child: MovieMenu(_movie)),
            Expanded(child: MovieInfo(_movie)),
          ],
        ),
      ),
    );
  }
}
