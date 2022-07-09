import 'movie.dart';
import 'playlist.dart';
import 'rating.dart';

class User {
  String uid; // User ID do Firebase
  String userName; // Nome
  String? profilePictureUrl; // Foto do Usuário
  List<Movie>? favorites; //Lista de Filmes Favoritos
  List<Rating>? ratings; //Lista de Avaliações;
  List<Playlist>? playlists; //Lista de PlayLists;

  User({
    required this.uid,
    required this.userName,
  });

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
