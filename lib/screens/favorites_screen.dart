import 'package:catalogo_filmes/models/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/movie_item.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          actions: [
            Container(padding: EdgeInsets.all(10), child: Icon(Icons.menu))
          ],
          title: const Text('Favorite Movies'),
        ),
        body: Container(
            color: Theme.of(context).colorScheme.primary,
            child: SingleChildScrollView(
              child: Consumer<Favorites>(
                builder: (context, favorites, child) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: favorites.favoriteMovies.length,
                    itemBuilder: (BuildContext context, int index) =>
                        MovieItem(favorites.favoriteMovies[index]),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                      mainAxisExtent: 250,
                    ),
                  );
                },
              ),
            )));
  }
}
