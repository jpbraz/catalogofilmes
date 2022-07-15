import 'dart:convert';
import 'dart:math';

import 'package:catalogo_filmes/models/rating.dart';
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

  Future<void> saveRatingForm(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    bool hasComment = data['comment'] != null;

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
      movie: data['movie'] as Movie,
      value: data['value'] as double,
      comment: hasComment ? data['comment'] as String : null,
      userApp: userLocal,
    );

    if (hasId) {
      return _updateRatingInFirebase(rating.id, rating);
    } else {
      return _addRatingInFirebase(rating);
    }
  }

  Future<void> _addRatingInFirebase(Rating rating) {
    final future = http.post(Uri.parse('$_baseUrl/ratings_and_reviews.json'),
        body: jsonEncode({
          "movie": rating.movie,
          "value": rating.value,
          "comment": rating.comment,
          "userApp": {
            "uid": rating.userApp.uid,
            "userName": rating.userApp.userName,
            "profilePictureUrl": rating.userApp.profilePictureUrl,
          },
        }));
    return future.then((response) {
      final id = jsonDecode(response.body)['name'];
      print("Avaliaçao gravadas com sucesso. ID retornado: $id");
    });
  }

  Future<void> _updateRatingInFirebase(String id, Rating rating) async {
    final url = "$_baseUrl/ratings_and_reviews/$id.json";
    await http
        .patch(
          Uri.parse(url),
          body: jsonEncode(
            {
              //"movie": rating.movie,
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
    final response = await http.get(Uri.parse(url));

    List<Rating> result = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);

      map.forEach((key, value) {
        if (value['movie']['id'].toString() == movie.id) {
          Rating rating = Rating.fromJson(key, value);
          result.add(rating);
        }
      });
      return result;
    } else {
      throw Exception('Failed to load rating');
    }
  }
}
