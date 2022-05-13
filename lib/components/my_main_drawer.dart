import 'dart:convert';

import 'package:catalogo_filmes/models/favorites.dart';
import 'package:catalogo_filmes/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyMainDrawer extends StatelessWidget {
  const MyMainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.primary,
        height: 100,
        padding: const EdgeInsets.only(top: 60),
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
                margin: const EdgeInsets.only(top: 60, left: 60),
                width: 200,
                child: Row(
                  children: [
                    const Icon(Icons.book_rounded),
                    Text(
                      ' Catalog',
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
                margin: const EdgeInsets.only(top: 10, left: 60),
                width: 200,
                child: Row(
                  children: [
                    const Icon(Icons.favorite),
                    Text(
                      ' Favorites',
                      style: TextStyle(
                          fontSize: 27,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Consumer<Favorites>(
              builder: (BuildContext context, value, Widget? child) {
                return GestureDetector(
                  onTap: (() {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    //value.removeAllFavoriteMovie();
                  }),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, left: 60),
                    width: 200,
                    child: Row(
                      children: [
                        const Icon(Icons.logout),
                        Text(
                          ' Logout',
                          style: TextStyle(
                              fontSize: 27,
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
