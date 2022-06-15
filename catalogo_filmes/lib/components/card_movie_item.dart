import 'dart:math';

import 'package:catalogo_filmes/providers/favorites_provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class CardMovieItem extends StatefulWidget {
  Movie movie;

  CardMovieItem(this.movie);

  @override
  State<CardMovieItem> createState() => _CardMovieItemState();
}

class _CardMovieItemState extends State<CardMovieItem> {
  @override
  Widget build(BuildContext context) {
    var favorites = context.watch<Favorites>();
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Stack(
            children: [
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
                            icon: Icon(
                              Icons.favorite,
                              size: 30,
                              color: Colors.red[800],
                            ),
                            onPressed: () {
                              setState(() {
                                favorites.removeFavoriteMovie(widget.movie);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                top: 0,
              )
            ],
          ),
        ),
        // Expanded(
        //   flex: 1,
        //   child: Container(
        //     padding: const EdgeInsets.only(left: 10),
        //     color: Theme.of(context).colorScheme.primary,
        //     height: MediaQuery.of(context).size.height * 0.4,
        //     width: MediaQuery.of(context).size.width,
        //     child: ListView(children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Título Completo: ${widget.movie.title}',
        //             style: Theme.of(context).textTheme.headline2,
        //           ),
        //           const SizedBox(
        //             height: 20,
        //           ),
        //           Text(
        //             'Ano: ${widget.movie.year}',
        //             style: Theme.of(context).textTheme.headline2,
        //           ),
        //           const SizedBox(
        //             height: 20,
        //           ),
        //           Text(
        //             'Diretores: ${widget.movie.directors}',
        //             style: Theme.of(context).textTheme.headline2,
        //           ),
        //           const SizedBox(
        //             height: 20,
        //           ),
        //           Text(
        //             'Elenco: ${widget.movie.crew}',
        //             style: Theme.of(context).textTheme.headline2,
        //           ),
        //           const SizedBox(
        //             height: 20,
        //           ),
        //           Text(
        //             'Nota IMDb: ${widget.movie.rate}',
        //             style: Theme.of(context).textTheme.headline2,
        //           ),
        //           const SizedBox(
        //             height: 20,
        //           ),
        //           Text(
        //             'Sinopse: ${widget.movie.plot}',
        //             style: Theme.of(context).textTheme.headline2,
        //           ),
        //         ],
        //       ),
        //     ]),
        //   ),
        // ),
      ],
    );
  }
}
