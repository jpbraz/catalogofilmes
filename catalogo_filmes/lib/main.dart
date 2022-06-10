import 'package:catalogo_filmes/providers/favorites_provider.dart';
import 'package:catalogo_filmes/providers/catalog_provider.dart';
import 'package:catalogo_filmes/providers/playLists_provider.dart';
import 'package:catalogo_filmes/screens/catalog_screen.dart';
import 'package:flutter/material.dart';
import 'package:catalogo_filmes/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/details_screen.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CatalogProvider(),
        ),
        ChangeNotifierProvider(create: (context) => Favorites()),
        ChangeNotifierProvider(create: (context) => PlayLists()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/catalog',
        theme: ThemeData().copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.black,
                  secondary: Colors.blue[800],
                  tertiary: Colors.white,
                ),
            textTheme: ThemeData().textTheme.copyWith(
                headline1: const TextStyle().copyWith(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato'),
                headline2: const TextStyle().copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato'),
                headline3: const TextStyle().copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        'Lato')), //verificar, nao esta funcionando ainda
            iconTheme: ThemeData().iconTheme.copyWith(
                  color: Colors.white,
                ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(color: Colors.white),
            )),
        routes: {
          AppRoutes.CATALOG: ((context) => CatalogScreen()),
          AppRoutes.DETAILS: ((context) => DetailsScreen()),
          //AppRoutes.FAVORITES: ((context) => FavoritesScreen()),
        },
      ),
    );
  }
}
