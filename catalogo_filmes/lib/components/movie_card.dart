import 'package:catalogo_filmes/providers/catalog_provider.dart';
import 'package:catalogo_filmes/utils/app_routes.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  late final selectedMovie;

  MovieCard(this.movie);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<CatalogProvider>(context, listen: false)
            .fetchMovieById(widget.movie.id)
            .then((movie) {
          widget.selectedMovie = movie;
          Navigator.of(context)
              .pushNamed(AppRoutes.DETAILS, arguments: widget.selectedMovie);
        });
      },
      child: Card(
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  opacity: 20,
                  image: NetworkImage(widget.movie.imageUrl),
                  fit: BoxFit.fill),
            ),
          ),
          Positioned(
            child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.black87,
                child: Text(
                  widget.movie.title,
                  style: Theme.of(context).textTheme.headline1,
                )),
            bottom: 10,
            left: 40,
            right: 3,
          )
        ]),
      ),
    );
  }
}
