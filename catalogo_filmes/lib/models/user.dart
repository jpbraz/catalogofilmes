import 'movie.dart';
import 'playlist.dart';
import 'rating.dart';

class UserApp {
  String uid; // User ID do Firebase
  String userName; // Nome
  String? profilePictureUrl; // Foto do Usuário
  List<Movie>? favorites; //Lista de Filmes Favoritos
  List<Rating>? ratings; //Lista de Avaliações;
  List<Playlist>? playlists; //Lista de PlayLists;

  UserApp({
    required this.uid,
    required this.userName,
    this.profilePictureUrl,
  });

  factory UserApp.fromJson(String id, Map<String, dynamic> json) {
    return UserApp(
      uid: json['uid'],
      userName: json['userName'],
      profilePictureUrl: json["profilePictureUrl"],
    );
  }

  addMovieToListOfFavorites(Movie movie) {
    favorites?.add(movie);
  }

  removeMovieFromListOfFavorites(Movie movie) {
    favorites?.remove(movie);
  }

  addMovieToListOfRatings(Movie movie) {
    favorites?.add(movie);
  }

  removeMovieFromListOfRatings(Movie movie) {
    favorites?.remove(movie);
  }

  addMovieToListOfPlaylists(Movie movie) {
    favorites?.add(movie);
  }

  removeMovieFromListOfPlaylists(Movie movie) {
    favorites?.remove(movie);
  }
}
