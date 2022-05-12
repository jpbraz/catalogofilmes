import 'package:catalogo_filmes/components/my_main_drawer.dart';
import 'package:catalogo_filmes/models/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/card_movie_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: const Text('Favorite Movies'),
      ),
      drawer: const MyMainDrawer(),
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
        color: Theme.of(context).colorScheme.primary,
        child: SingleChildScrollView(
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
      ),
    );
  }
}
