import 'dart:convert';

import '/providers/playlists_provider.dart';
import 'movie.dart';

class Playlist {
  String id;
  String name;
  String creationDate;
  String? description;
  List<Movie>? movieList;
  String userID;

  Playlist({
    required this.id,
    required this.name,
    required this.creationDate,
    this.description,
    this.movieList,
    required this.userID,
  });

  addMovieToList(Movie movie) {
    movieList?.add(movie);
  }

  removeMovieFromList(Movie movie) async {
    movieList?.remove(movie);

    PlayLists().updatePlaylist(this);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'creationDate': creationDate,
      'description': description,
      'movieList': movieList != null
          ? movieList!.map((movie) => movie.toJson()).toList()
          : [],
      'userID': userID,
    };
  }

  factory Playlist.fromJson(String id, Map<String, dynamic> json) {
    List<Movie> localMovieList = [];

    if (json['movielist'] != null) {
      localMovieList = json['movielist']
          .map((movie) => Movie.fromJson(json['id'] as String, movie))
          .toList();
    }
    // Map<String, dynamic> mapMovieList = jsonDecode(json['movieList']);

    // mapMovieList.forEach((key, value) {
    //   Movie movie = Movie.fromJson(key, value);
    //   localMovieList.add(movie);
    // });

    return Playlist(
      id: id,
      name: json['name'],
      creationDate: json['creationDate'],
      description: json['description'],
      movieList: localMovieList,
      userID: json['userID'],
    );
  }
}
