import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/movie_items/favorite_movie_item.dart';
import '../components/navigation/drawer.dart';
import '../providers/favorites_provider.dart';

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
      drawer: MyMainDrawer(),
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
        color: Theme.of(context).colorScheme.primary,
        child: Consumer<Favorites>(
          builder: (context, favorites, child) {
            return favorites.favoriteMovies.isEmpty
                ? const Center(
                    child: Text(
                      'You dont have any favorite movie!',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: favorites.favoriteMovies.length,
                    itemBuilder: (BuildContext context, int index) =>
                        CardMovieItem(
                      favorites.favoriteMovies[index],
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 100,
                            mainAxisExtent: 300),
                  );
          },
        ),
      ),
    );
  }
}
