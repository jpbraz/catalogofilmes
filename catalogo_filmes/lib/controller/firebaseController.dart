import 'dart:convert';
import 'dart:math';

import 'package:catalogo_filmes/models/rating.dart';
import 'package:catalogo_filmes/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/movie.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class FirebaseController {
  FirebaseController();
  final _baseUrl =
      dotenv.get('FIREBASE_URL'); // Colocar valor da variável no .env

  final user = AuthService().auth.currentUser!;

  Future<void> saveRatingForm(Map<String, Object> data) async {
    bool hasId = data['id'] != null;
    bool hasComment = data['comment'] != null;
    Movie movie = data['movie'] as Movie;
    final movieFounded = await Movies().getMovie(movie.id);

    if (movieFounded == null) {
      Movies().addMovie(movie);
    }

    String userName =
        user.displayName != null ? user.displayName.toString() : 'Sem nome';
    String photoURL = user.photoURL != null
        ? user.photoURL.toString()
        : '../assets/image/person-icon.png';

    UserApp userLocal = UserApp(
      uid: user.uid.toString(),
      userName: userName,
      profilePictureUrl: photoURL,
    );
    print(user);
    print("[===DATA]: ${userLocal.profilePictureUrl}");
    final rating = Rating(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      value: data['value'] as double,
      comment: hasComment ? data['comment'] as String : null,
      userApp: userLocal,
    );

    if (hasId) {
      return _updateRatingInFirebase(rating.id, rating, movie.id);
    } else {
      return _addRatingInFirebase(movie.id, rating);
    }
  }

  Future<void> _addRatingInFirebase(String movieID, Rating rating) {
    final future = http.patch(
      Uri.parse('$_baseUrl/movies/$movieID/ratings.json'),
      body: jsonEncode(
        {
          "value": rating.value,
          "comment": rating.comment,
          "userApp": {
            "uid": rating.userApp.uid,
            "userName": rating.userApp.userName,
            "profilePictureUrl": rating.userApp.profilePictureUrl,
          },
        },
      ),
    );
    return future.then((response) {
      final id = jsonDecode(response.body)['name'];
      debugPrint("Avaliaçao gravadas com sucesso. ID retornado: $id");
    });
  }

  Future<void> _updateRatingInFirebase(
      String ratingID, Rating rating, String movieID) async {
    final url = "$_baseUrl/movies/$movieID/ratings/$ratingID.json";
    await http
        .patch(
          Uri.parse(url),
          body: jsonEncode(
            {
              "value": rating.value,
              "comment": rating.comment,
            },
          ),
        )
        .then((response) => print(
            "Status: ${response.statusCode.toString()} = ${response.reasonPhrase.toString()}"));
  }

  Future<void> deleteRatingInFirebase(Rating rating) async {
    final url = "$_baseUrl/ratings_and_reviews/${rating.id}.json";
    bool isOwner = rating.userApp.uid == user.uid ? true : false;
    if (isOwner) {
      return http.delete(Uri.parse(url)).then((response) {
        print(response.statusCode);
        if (response.statusCode >= 400) {
          throw Exception("Could not delete!");
        }
      });
    }
  }

  Future<Rating> getRatingInFirebaseById(String id) async {
    final url = "$_baseUrl/ratings_and_reviews/$id.json";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return Rating.fromJson(id, json);
    } else {
      throw Exception('Failed to load rating');
    }
  }

  Future<List<Rating>> getRatingsInFirebaseByMovie(Movie movie) async {
    final url = "$_baseUrl/ratings_and_reviews.json";
    try {
      final response = await http.get(Uri.parse(url));

      List<Rating> result = [];

      if (response.statusCode == 200 && response.body != "null") {
        Map<String, dynamic> map = jsonDecode(response.body);

        map.forEach((key, value) {
          if (value['movie']['id'].toString() == movie.id) {
            Rating rating = Rating.fromJson(key, value);
            result.add(rating);
          }
        });
      } else {
        throw Exception('Failed to load rating');
      }

      return result;
    } catch (error) {
      rethrow;
    }
  }
}
