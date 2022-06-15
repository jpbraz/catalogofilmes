import 'package:catalogo_filmes/providers/catalog_provider.dart';
import 'package:catalogo_filmes/utils/app_routes.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;

  const MovieCard(this.movie);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isDetailsOfMovieLoaded = false;
  late Movie selectedMovie;
  bool isLoading = false;

  @override
  void initState() {
    isDetailsOfMovieLoaded =
        Provider.of<CatalogProvider>(context, listen: false)
            .movies
            .any((movie) {
      if (movie.id == widget.movie.id) {
        if (movie.plot != null) {
          return true;
        }
      }
      return false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var catalog = context.watch<CatalogProvider>();
    return InkWell(
      onTap: () {
        if (!isDetailsOfMovieLoaded) {
          catalog.fetchMovieById(widget.movie.id).then((_) {
            setState(() {
              selectedMovie = catalog.movies
                  .firstWhere((movie) => movie.id == widget.movie.id);
              isDetailsOfMovieLoaded = true;
            });
            Navigator.of(context)
                .pushNamed(AppRoutes.DETAILS, arguments: selectedMovie);
          });
        } else {
          setState(() {
            selectedMovie = catalog.movies
                .firstWhere((movie) => movie.id == widget.movie.id);
          });
          Navigator.of(context)
              .pushNamed(AppRoutes.DETAILS, arguments: selectedMovie);
        }
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
                padding: const EdgeInsets.all(10),
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
