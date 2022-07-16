import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/movie.dart';

class Movies with ChangeNotifier {
  // final _baseURL = dotenv.get('FIREBASE_URL');
  final _databaseMovieRef = FirebaseDatabase.instance.ref('/movies');

  Future<void> addMovie(Movie movie) async {
    try {
      await _databaseMovieRef.child(movie.id).set(movie.toJson());

      // final response = await http.post(Uri.parse('$_baseURL/movies.json'),
      //     body: jsonEncode(
      //       {
      //         movie.id: {
      //           'id': movie.id,
      //           'title': movie.title,
      //           'fullTitle': movie.fullTitle,
      //           'crew': movie.crew,
      //           'rate': movie.rate,
      //           'year': movie.year,
      //           'imageUrl': movie.imageUrl,
      //           'releaseDate': movie.releaseDate,
      //           'runTimeStr': movie.runTimeStr,
      //           'plot': movie.plot,
      //           'directors': movie.directors,
      //         },
      //       },
      //     ));

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future getMovie(String id) async {
    final response = await _databaseMovieRef.child(id).get();

    if (!response.exists) {
      // final data = jsonDecode(response.value);
      // final loadedMovie = Movie(
      //   id: id,
      //   title: data['title'],
      //   fullTitle: data['fullTitle'],
      //   crew: data['crew'],
      //   rate: data['rate'],
      //   year: data['year'],
      //   imageUrl: data['imageUrl'],
      //   releaseDate: data['releaseDate'],
      //   runTimeStr: data['runTimeStr'],
      //   plot: data['plot'],
      //   directors: data['directors'],
      // );

      // return loadedMovie;
    } else {
      debugPrint("[getMovie] response.body is empty");
      return null;
    }
  }
}
