import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '/models/movie.dart';

class Favorites extends ChangeNotifier {
  List<Movie> favoriteMovies = [];

  final _baseURL = dotenv.get('FIREBASE_URL');

  void addFavoriteMovie(Movie movie) async {
    String id = await getID();

    if (id == '') {
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

  void removeFavoriteMovie(Movie movie) async {
    favoriteMovies.removeWhere((element) => element.id == movie.id);

    String id = await getID();

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

    String id = await getID();

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

  Future<String> getID() async {
    final response = await http.get(
      Uri.parse('$_baseURL/favorites.json'),
    );

    final extractedData = json.decode(response.body);

    if (extractedData == null) {
      return '';
    }

    final id = extractedData.keys.toList()[0];

    return id;
  }

  bool hasMovie(Movie movie) {
    final result =
        favoriteMovies.where((element) => element.id == movie.id).toList();

    return result.isNotEmpty;
  }
}
