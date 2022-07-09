import 'package:catalogo_filmes/components/widgets/auth_check.dart';
import 'package:catalogo_filmes/providers/favorites_provider.dart';
import 'package:catalogo_filmes/providers/catalog_provider.dart';
import 'package:catalogo_filmes/providers/playlists_provider.dart';
import 'package:catalogo_filmes/screens/catalog_screen.dart';
import 'package:catalogo_filmes/screens/favorites_screen.dart';
import 'package:catalogo_filmes/screens/movie_details_screen.dart';
import 'package:catalogo_filmes/screens/playlist_details_screen.dart';
import 'package:catalogo_filmes/screens/playlists_screen.dart';
import 'package:catalogo_filmes/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:catalogo_filmes/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'firebase_options.dart';
import 'screens/details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
    ChangeNotifierProvider<CatalogProvider>(
      create: (context) => CatalogProvider(),
    ),
    ChangeNotifierProvider<Favorites>(create: (context) => Favorites()),
    ChangeNotifierProvider<PlayLists>(create: (context) => PlayLists()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/startpage',
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
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato'),
              headline3: const TextStyle().copyWith(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato')), //verificar, nao esta funcionando ainda
          iconTheme: ThemeData().iconTheme.copyWith(
                color: Colors.white,
              ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.white),
          )),
      routes: {
        AppRoutes.STARTPAGE: (((context) => AuthCheck())),
        AppRoutes.CATALOG: ((context) => CatalogScreen()),
        AppRoutes.DETAILS: ((context) => DetailsScreen()),
        AppRoutes.PLAYLISTS: ((context) => PlaylistsScreen()),
        AppRoutes.PLAYLIST_DETAILS: ((context) => PlaylistDetailsScreen()),
        AppRoutes.MOVIE_DETAILS: ((context) => MovieDetailScreen()),
        AppRoutes.FAVORITES: ((context) => FavoritesScreen())
      },
    );
  }
}
