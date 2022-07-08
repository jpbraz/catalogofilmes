import 'package:flutter/material.dart';

import '/components/movie_items/rating_form.dart';
import '../../controller/firebaseController.dart';
import '../../models/rating.dart';

class MyListTileCardRatings extends StatelessWidget {
  List<Rating> myList;
  FirebaseController controller = FirebaseController();

  MyListTileCardRatings(this.myList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: myList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Rating myObject = myList[index];
        return Card(
          elevation: 2,
          shadowColor: Colors.grey,
          color: Theme.of(context).colorScheme.primary,
          child: ListTile(
            isThreeLine: true,
            onTap: () => _onTapListTile(context, myObject),
            title: Text(
              myObject.value.toStringAsFixed(1),
              style: Theme.of(context).textTheme.headline2,
            ),
            subtitle: Text(myObject.comment!,
                style: Theme.of(context).textTheme.headline1),
            leading: SizedBox(
              height: 50,
              width: 50,
              child: Image.network(
                'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png',
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