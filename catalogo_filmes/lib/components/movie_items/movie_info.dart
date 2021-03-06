import 'package:flutter/material.dart';

import '../../models/movie.dart';
import 'rating_list.dart';

class MovieInfo extends StatelessWidget {
  final Movie _movie;

  const MovieInfo(this._movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Theme.of(context).colorScheme.primary,
      child: ListView(children: [
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
        const SizedBox(
          height: 20,
        ),
        Text(
          'Commentaries: ',
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(
          height: 10,
        ),
        MyListTileCardRatings(_movie),
      ]),
    );
  }
}
