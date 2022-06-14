import 'dart:convert';

import 'package:catalogo_filmes/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class Favorites extends ChangeNotifier {
  List<Movie> favoriteMovies = [];
  late String id = '';

  final _baseURL = dotenv.get('FIREBASE_URL');

  void addFavoriteMovie(Movie movie) {
    if (id.isEmpty) {
      favoriteMovies.add(movie);
      http.post(
        Uri.parse('$_baseURL/favorites.json'),
        body: jsonEncode({
          'movies': favoriteMovies,
        }),
      );
    } else {
      favoriteMovies.add(movie);
      http.patch(
        Uri.parse('$_baseURL/favorites/$id.json'),
        body: jsonEncode({
          'movies': favoriteMovies,
        }),
      );
    }

    notifyListeners();
  }

  void removeFavoriteMovie(Movie movie) {
    favoriteMovies.removeWhere((element) => element.id == movie.id);
    http.patch(
      Uri.parse('$_baseURL/favorites/$id.json'),
      body: jsonEncode({
        'movies': favoriteMovies,
      }),
    );

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

    if (extractedData == null) {
      return;
    }

    id = extractedData.keys
        .toString()
        .substring(1, extractedData.keys.toString().length - 1);

    favoriteMovies.clear();
    for (var movie in extractedData[id]['movies']) {
      favoriteMovies.add(
        Movie(
          id: movie['id'],
          title: movie['title'],
          fullTitle: movie['fullTitle'],
          crew: movie['crew'],
          rate: movie['rate'],
          year: movie['year'],
          imageUrl: movie['imageUrl'],
          plot: movie['plot'],
          releaseDate: movie['releaseDate'],
          directors: movie['directors'],
        ),
      );
    }
  }

  bool hasMovie(Movie movie) {
    final result =
        favoriteMovies.where((element) => element.id == movie.id).toList();

    return result.isNotEmpty;
  }
}
