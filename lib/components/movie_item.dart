import 'package:catalogo_filmes/models/movie.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(movie.originalTitle as String),
            Text(movie.title as String),
          ],
        ));
  }
}
