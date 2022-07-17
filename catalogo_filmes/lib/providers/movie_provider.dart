import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class Movies with ChangeNotifier {
  final _databaseMovieRef = FirebaseDatabase.instance.ref('/movies');

  Future<void> addMovie(Movie movie) async {
    try {
      await _databaseMovieRef.child(movie.id).set(movie.toJson());

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future getMovie(String id) async {
    final response = await _databaseMovieRef.child(id).get();

    if (response.exists) {
      final loadedMovie =
          Movie.fromJson(response.key as String, response.value as Map);

      return loadedMovie;
    } else {
      debugPrint(
          "[INFO] getMovie in movie_provider: there isn't movie with id $id, in firebase_database.");
      return null;
    }
  }
}
