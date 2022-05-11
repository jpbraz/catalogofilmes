import 'package:catalogo_filmes/models/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/movie_item.dart';
import '../utils/app_routes.dart';

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
        drawer: Drawer(
          child: Container(
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.primary,
            height: 100,
            padding: EdgeInsets.only(top: 60),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'NerdCatalog',
                        style: TextStyle(
                            fontSize: 40,
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.CATALOG);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 60, left: 60),
                      width: 200,
                      child: Row(
                        children: [
                          Icon(Icons.book_rounded),
                          Text(
                            'Catalog',
                            style: TextStyle(
                                fontSize: 27,
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.of(context).pushNamed(AppRoutes.FAVORITES);
                    }),
                    child: Container(
                      margin: EdgeInsets.only(top: 10, left: 60),
                      width: 200,
                      child: Row(
                        children: [
                          Icon(Icons.favorite),
                          Text(
                            'Favorites',
                            style: TextStyle(
                                fontSize: 27,
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(top: 60, left: 10, right: 10),
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
