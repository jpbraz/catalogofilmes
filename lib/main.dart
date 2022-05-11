import 'package:catalogo_filmes/models/favorites.dart';
import 'package:catalogo_filmes/screens/catalog_screen.dart';
import 'package:catalogo_filmes/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:catalogo_filmes/screens/start_screen.dart';
import 'package:catalogo_filmes/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Favorites(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.black,
                secondary: Colors.blue[800],
                tertiary: Colors.white,
              ),
          textTheme: ThemeData().textTheme.copyWith(
              headline1: const TextStyle().copyWith(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              headline2: const TextStyle().copyWith(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
          iconTheme: ThemeData().iconTheme.copyWith(
                color: Colors.white,
              ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.white),
          )),
      routes: {
        AppRoutes.HOME: (context) => StartScreen(),
        AppRoutes.CATALOG: ((context) => CatalogScreen()),
        AppRoutes.DETAILS: ((context) => DetailsScreen())
      },
    );
  }
}
