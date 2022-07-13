import 'package:flutter/material.dart';

import '../../utils/app_routes.dart';

class NavigationRoutesButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        color: Theme.of(context).colorScheme.primary,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                ),
              ),
            ]));
  }
}
