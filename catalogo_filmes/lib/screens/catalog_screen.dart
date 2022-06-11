import 'package:catalogo_filmes/components/movie_card.dart';
import 'package:catalogo_filmes/providers/catalog_provider.dart';
import 'package:catalogo_filmes/providers/playlists_provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/drawer.dart';

class CatalogScreen extends StatefulWidget {
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  bool _isLoading = false;
  bool _isInfoLoaded = false;

  @override
  void initState() {
    _isLoading = true;

    if (!_isInfoLoaded) {
      Provider.of<CatalogProvider>(context, listen: false)
          .fetchMovies()
          .then((_) {
        setState(() {
          _isLoading = false;
          _isInfoLoaded = true;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var catalogInfo = context.watch<CatalogProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Movie Catalog'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Top 250 movies',
                        style: Theme.of(context).textTheme.headline3),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 5,
                              crossAxisCount: 2),
                      itemCount: catalogInfo.movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(catalogInfo.movies[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
      drawer: const MyMainDrawer(),
    );
  }
}
