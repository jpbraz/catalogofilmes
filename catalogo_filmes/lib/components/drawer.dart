import 'package:catalogo_filmes/utils/app_routes.dart';
import 'package:flutter/material.dart';

class MyMainDrawer extends StatelessWidget {
  const MyMainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                'NerdCatalog',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              color: Theme.of(context).colorScheme.primary,
              height: MediaQuery.of(context).size.height * 0.857,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.CATALOG);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Catalog',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Theme.of(context).colorScheme.tertiary,
                                )),
                            const SizedBox(
                              width: 32,
                            ),
                            Icon(
                              Icons.menu_book_rounded,
                              size: 40,
                              color: Theme.of(context).colorScheme.tertiary,
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.FAVORITES);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Favorites',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Theme.of(context).colorScheme.tertiary,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.favorite,
                              size: 40,
                              color: Theme.of(context).colorScheme.tertiary,
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.PLAYLISTS);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Playlists',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Theme.of(context).colorScheme.tertiary,
                                )),
                            const SizedBox(
                              width: 12,
                            ),
                            Icon(
                              Icons.playlist_play,
                              size: 45,
                              color: Theme.of(context).colorScheme.tertiary,
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
