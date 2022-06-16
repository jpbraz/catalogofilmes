import 'package:catalogo_filmes/components/rating_form.dart';
import 'package:catalogo_filmes/components/rating_list.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../controller/firebaseController.dart';
import '../models/movie.dart';
import '../models/rating.dart';

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

    super.initState();
  }

  void getRating(Movie movie) async {
    List<Rating> aux =
        await FirebaseController().getRatingsInFirebaseByMovie(movie);
    setState(() {
      ratings = aux;
    });
  }

  @override
  Widget build(BuildContext context) {
    getRating(widget._movie);
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
        MyListTileCardRatings(ratings),
      ],
    );
  }
}
