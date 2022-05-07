import 'package:flutter/material.dart';
import './screens/start_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
      theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.black,
                secondary: Colors.blue[800],
                tertiary: Colors.white,
              ),
          textTheme: ThemeData().textTheme.copyWith(
              headline1: const TextStyle().copyWith(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold))),
    );
  }
}
