import 'package:catalogo_filmes/components/commentaries_info.dart';
import 'package:catalogo_filmes/components/movie_menu.dart';
import 'package:catalogo_filmes/providers/playlists_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            MovieMenu(_movie),
            CommentariesInfo(_movie),
          ],
        ),
      ),
    );
  }
}
