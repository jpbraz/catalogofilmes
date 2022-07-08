import 'package:flutter/material.dart';

import '../../controller/firebaseController.dart';
import '../../models/rating.dart';
import '../movie_items/rating_form.dart';

class MyListTileCardRatings extends StatelessWidget {
  List<Rating> myList;
  FirebaseController controller = FirebaseController();

  MyListTileCardRatings(this.myList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Rating myObject = myList[index];
        return Card(
          child: ListTile(
            onTap: () => _onTapListTile(context, myObject),
            title: Text(myObject.value.toStringAsFixed(1)),
            subtitle: Text(myObject.comment!),
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Image.network(
                myObject.movie.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            trailing: IconButton(
              onPressed: () => _removeWithSnackBar(context, 'Remove', myObject),
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }

  void _removeWithSnackBar(context, String label, Rating myObject) {
    final snackBar = SnackBar(
      content: const Text('Do you want remove this object?'),
      action: SnackBarAction(
        label: label,
        onPressed: () {
          controller.deleteRatingInFirebase(myObject.id);
          return;
          // Some code to undo the change.
        },
      ),
    );
    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onTapListTile(context, Rating myObject) {
    // ignore: avoid_print
    print("Editando id: ${myObject.id.toString()}");
    _openModelForm(context, myObject).then(
      (_) => {
        print("${myObject.id} alterado/fechado com sucesso."),
      },
    );
  }

  Future<void> _openModelForm(context, Rating myObject) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Edit'),
          titlePadding: const EdgeInsets.all(20),
          content: SizedBox(
            width: 500,
            child: RatingForm(movie: myObject.movie, rating: myObject),
          ),
          contentPadding: EdgeInsets.zero,
        ),
      );
}
