import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/favorites_provider.dart';
import '../../models/movie.dart';

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
                top: 0,
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
