import 'package:catalogo_filmes/components/rating_form.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../controller/firebaseController.dart';
import '../models/movie.dart';
import '../models/rating.dart';
import 'movie_info.dart';

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

  void deleteRating(String id) async {
    await FirebaseController().deleteRatingInFirebase(id);
    setState(() {
      ratings;
    });
  }

  @override
  Widget build(BuildContext context) {
    getRating(widget._movie);
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10),
      color: Theme.of(context).colorScheme.primary,
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          MovieInfo(widget._movie),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Commentaries: ",
                  style: Theme.of(context).textTheme.headline2,
                ),
                WidgetSpan(
                  child: IconButton(
                    icon: const Icon(Icons.add, size: 20),
                    padding: const EdgeInsets.only(left: 200, top: 25),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => RatingForm(
                                movie: widget._movie,
                              ));
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ListView.builder(
                itemCount: ratings.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Rating currentItem = ratings[index];
                  return Row(
                    children: [
                      Expanded(
                          child: Text(
                        "${currentItem.value.toString()} - \"${currentItem.comment}\"",
                        style: Theme.of(context).textTheme.headline2,
                      )),
                      const SizedBox(
                        width: 50,
                        height: 5,
                      ),
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => RatingForm(
                                      movie: widget._movie,
                                      rating: currentItem,
                                    ));
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.delete, size: 20),
                          onPressed: () {
                            deleteRating(currentItem.id);
                          },
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
