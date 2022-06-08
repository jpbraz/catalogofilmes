import 'package:catalogo_filmes/components/drawer.dart';
import 'package:catalogo_filmes/models/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/card_movie_item_old.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Favorite Movies'),
      ),
      drawer: const MyMainDrawer(),
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
        color: Theme.of(context).colorScheme.primary,
        child: Consumer<Favorites>(
          builder: (context, favorites, child) {
            return GridView.builder(
              shrinkWrap: true,
              itemCount: favorites.favoriteMovies.length,
              itemBuilder: (BuildContext context, int index) =>
                  CardMovieItem(favorites.favoriteMovies[index], true, true),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 250,
              ),
            );
          },
        ),
      ),
    );
  }
}
