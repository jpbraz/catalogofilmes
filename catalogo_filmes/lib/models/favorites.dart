import 'package:catalogo_filmes/models/movie.dart';
import 'package:flutter/material.dart';

class Favorites extends ChangeNotifier {
  List<Movie> favoriteMovies = [];

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
