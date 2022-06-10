import 'package:catalogo_filmes/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Favorites extends ChangeNotifier {
  List<Movie> favoriteMovies = [];
  final _baseURL = dotenv.get('FIREBASE_URL');

  void addFavoriteMovie(Movie movie) {
    favoriteMovies.add(movie);
    notifyListeners();
  }

  void removeFavoriteMovie(Movie movie) {
    favoriteMovies.remove(movie);
    notifyListeners();
  }

  void removeAllFavoriteMovie() {
    favoriteMovies.clear();
    notifyListeners();
  }
}
