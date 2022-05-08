import 'package:flutter/material.dart';

import '../models/movie.dart';

class DetailsScreen extends StatelessWidget {
  final Movie movie;
  const DetailsScreen(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [Text(movie.title as String)],
    ));
  }
}
