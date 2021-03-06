import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../models/movie.dart';

class CatalogProvider with ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  Future<void> fetchMovies() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://imdb-api.com/en/API/Top250Movies/${dotenv.get('API_KEY')}'),
      );
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final _baseURL = dotenv.get('FIREBASE_URL');

      List<Movie> loadedMovies = [];
      for (var movie in data['items']) {
        loadedMovies.add(Movie(
            id: movie['id'],
            title: movie['title'],
            fullTitle: movie['fullTitle'],
            crew: movie['crew'],
            rate: movie['imDbRating'],
            year: movie['year'],
            imageUrl: movie['image']));
      }
      _movies = loadedMovies;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchMovieById(String id) async {
    try {
      final response = await http.get(Uri.parse(
          'https://imdb-api.com/en/API/Title/${dotenv.get('API_KEY')}/$id'));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      Movie newMovie = Movie(
          id: data['id'],
          title: data['title'],
          fullTitle: data['fullTitle'],
          crew: data['stars'],
          rate: data['imDbRating'],
          year: data['year'],
          imageUrl: data['image'],
          plot: data['plot'],
          releaseDate: data['releaseDate'],
          runTimeStr: data['runTimeStr'],
          directors: data['directors']);
      _movies[_movies.indexOf(
          _movies.firstWhere((movie) => movie.id == newMovie.id))] = newMovie;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
