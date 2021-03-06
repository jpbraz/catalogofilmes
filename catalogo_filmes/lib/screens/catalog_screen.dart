import 'package:catalogo_filmes/screens/notifications_screen.dart';
import 'package:catalogo_filmes/services/auth_service.dart';
import 'package:catalogo_filmes/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/catalog_provider.dart';
import '../providers/playlists_provider.dart';
import '../components/movie_items/movie_card.dart';
import '../components/navigation/drawer.dart';
import '../providers/favorites_provider.dart';
import '../services/firebase_messaging_service.dart';

class CatalogScreen extends StatefulWidget {
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    initilizeFirebaseMessaging();
    _isLoading = true;
    Provider.of<AuthService>(context, listen: false).downloadUserPhoto();
    if (Provider.of<CatalogProvider>(context, listen: false).movies.isEmpty) {
      Provider.of<CatalogProvider>(context, listen: false)
          .fetchMovies()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      Provider.of<PlayLists>(context, listen: false).fetchPlaylists();
      Provider.of<Favorites>(context, listen: false).fetchFavorites();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
    Provider.of<PlayLists>(context, listen: false)
        .fetchPlaylists()
        .then((_) {});
    super.initState();
  }

  @override
  initilizeFirebaseMessaging() async {
    await Provider.of<FirebaseMessagingService>(context, listen: false)
        .initialize();
  }

  @override
  Widget build(BuildContext context) {
    var catalogInfo = context.watch<CatalogProvider>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (cxt) {
                      return const NotificationsScreen();
                    }),
                  );
                },
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '${Provider.of<NotificationService>(context).itemsCount}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
                  const SizedBox(
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
      drawer: MyMainDrawer(),
    );
  }
}
