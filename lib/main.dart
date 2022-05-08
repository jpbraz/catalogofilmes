import 'package:catalogo_filmes/screens/catalog_screen.dart';
import 'package:flutter/material.dart';
import './screens/start_screen.dart';
import './utils/app_routes.dart';

void main() {
  runApp(MyApp());
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
                  fontWeight: FontWeight.bold))),
      routes: {
        AppRoutes.HOME: (context) => StartScreen(),
        AppRoutes.CATALOG: ((context) => CatalogScreen()),
      },
    );
  }
}
