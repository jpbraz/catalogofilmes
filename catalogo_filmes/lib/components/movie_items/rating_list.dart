import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/movie.dart';
import '../../services/auth_service.dart';
import '/components/movie_items/rating_form.dart';
import '../../controller/firebaseController.dart';
import '../../models/rating.dart';

class MyListTileCardRatings extends StatefulWidget {
  Movie movie;
  MyListTileCardRatings(this.movie, {Key? key}) : super(key: key);

  @override
  State<MyListTileCardRatings> createState() => _MyListTileCardRatingsState();
}

class _MyListTileCardRatingsState extends State<MyListTileCardRatings> {
  FirebaseController controller = FirebaseController();

  List<Rating> myList = [];

  @override
  void initState() {
    updateMyList(widget.movie);
    super.initState();
  }

  void updateMyList(Movie movie) async {
    await controller.getRatingsInFirebaseByMovie(movie).then((value) {
      setState(() {
        myList = value;
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
                        movie: widget.movie,
                      )).then((_) => updateMyList(widget.movie));
            },
            icon: const Icon(Icons.add)),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: myList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Rating myObject = myList[index];
            return Card(
              elevation: 2,
              shadowColor: Colors.grey,
              color: Theme.of(context).colorScheme.primary,
              child: Consumer<AuthService>(
                builder: (context, auth, child) {
                  String userIDentifier = auth.user!.uid;
                  return ListTile(
                    isThreeLine: true,
                    onTap: () => userIDentifier == myObject.userApp.uid
                        ? _onTapListTile(context, myObject)
                        : null,
                    title: Text(
                      myObject.value.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    subtitle: Text(myObject.comment!,
                        style: Theme.of(context).textTheme.headline1),
                    /*leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: myObject.userApp.profilePictureUrl !=
                          null //auth.user!.photoURL != null
                      ? Image(
                          image: NetworkImage(myObject.userApp
                              .profilePictureUrl!), //NetworkImage(auth.user!.photoURL!),
                          fit: BoxFit.cover,
                        )
                      : const Image(
                          image: AssetImage('image/person-icon.png'),
                          fit: BoxFit.cover,
                        ),
                ),*/
                    trailing: userIDentifier == myObject.userApp.uid
                        ? IconButton(
                            onPressed: () => _removeWithSnackBar(
                                context, 'Remove', myObject),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        : const SizedBox(),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _removeWithSnackBar(context, String label, Rating myObject) {
    final snackBar = SnackBar(
      content: const Text('Do you want remove this object?'),
      action: SnackBarAction(
        label: label,
        onPressed: () {
          controller
              .deleteRatingInFirebase(widget.movie.id, myObject)
              .then((_) => updateMyList(widget.movie));
          return;
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onTapListTile(
    context,
    Rating myObject,
  ) {
    _openModelForm(context, myObject).then(
      (_) {
        updateMyList(widget.movie);
        debugPrint(
            "[INFO] ratingForm of rating ${myObject.id} changed or closed.");
      },
    );
  }

  Future<void> _openModelForm(
    context,
    Rating myObject,
  ) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Edit'),
          titlePadding: const EdgeInsets.all(20),
          content: SizedBox(
            width: 500,
            child: RatingForm(movie: widget.movie, rating: myObject),
          ),
          contentPadding: EdgeInsets.zero,
        ),
      );
}
