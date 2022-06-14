import 'dart:convert';

import 'package:catalogo_filmes/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class Favorites extends ChangeNotifier {
  List<Movie> favoriteMovies = [];
  final _baseURL = dotenv.get('FIREBASE_URL');

  Future<void> addFavoriteMovie(Movie movie) async {
    final response = await http.post(
      Uri.parse('$_baseURL/favorites.json'),
      body: jsonEncode({
        'movies': favoriteMovies,
      }),
    );
    favoriteMovies.add(movie);
    notifyListeners();
  }

  Future<void> removeFavoriteMovie(Movie movie) async {
    final response = await http.delete(
      Uri.parse('$_baseURL/favorites/${movie.id}.json'),
    );

    favoriteMovies.remove(movie);
    notifyListeners();
  }

  void removeAllFavoriteMovie() {
    favoriteMovies.clear();
    notifyListeners();
  }

  Future<void> fetchFavorites() async {
    final response = await http.get(
      Uri.parse('$_baseURL/favorites.json'),
    );
    final extractedData = json.decode(response.body);
  }
}
