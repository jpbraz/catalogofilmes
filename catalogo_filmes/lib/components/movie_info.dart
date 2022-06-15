import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieInfo extends StatelessWidget {
  final Movie _movie;

  MovieInfo(this._movie);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      )
    ]);
  }
}
