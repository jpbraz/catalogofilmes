import 'package:catalogo_filmes/components/movie_items/rating_form.dart';
import 'package:catalogo_filmes/components/movie_items/rating_list.dart';

import 'package:flutter/material.dart';

import '../../controller/firebaseController.dart';
import '../../models/movie.dart';
import '../../models/rating.dart';

class CommentariesInfo extends StatefulWidget {
  final Movie _movie;

  CommentariesInfo(this._movie);
  @override
  State<CommentariesInfo> createState() => _CommentariesInfoState();
}

class _CommentariesInfoState extends State<CommentariesInfo> {
  late List<Rating> ratings;

  @override
  void initState() {
    ratings = [];
    getRating(widget._movie);
    super.initState();
  }

  void getRating(Movie movie) async {
    await FirebaseController().getRatingsInFirebaseByMovie(movie).then((value) {
      setState(() {
        ratings = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => RatingForm(
                        movie: widget._movie,
                      ));
            },
            icon: const Icon(Icons.add)),
        MyListTileCardRatings(ratings, widget._movie),
      ],
    );
  }
}
