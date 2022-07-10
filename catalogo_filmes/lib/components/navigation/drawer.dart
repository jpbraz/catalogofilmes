import 'package:catalogo_filmes/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

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
              padding: const EdgeInsets.only(top: 50),
              color: Theme.of(context).colorScheme.primary,
              height: MediaQuery.of(context).size.height * 0.88745,
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
                    Divider(
                      thickness: 2,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Consumer<AuthService>(
                      builder: (context, auth, child) {
                        return auth.user!.email!.isNotEmpty
                            ? Center(
                                child: Text(
                                  auth.user!.email!.toString(),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              )
                            : const Center(
                                child: Text(
                                  'e-mail is null',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              );
                      },
                    ),
                    TextButton(
                      onPressed: () => context.read<AuthService>().logout(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Logout',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Theme.of(context).colorScheme.tertiary,
                              )),
                          const SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Icons.logout,
                            size: 45,
                            color: Theme.of(context).colorScheme.tertiary,
                          )
                        ],
                      ),
                    ),
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
