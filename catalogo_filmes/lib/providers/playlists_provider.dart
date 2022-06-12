import 'dart:convert';

import 'package:catalogo_filmes/providers/catalog_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/movie.dart';
import '../models/playlist.dart';
import 'package:http/http.dart' as http;

class PlayLists with ChangeNotifier {
  final Map<String, Playlist> _listOfPlayLists = {};
  final _baseURL = dotenv.get('FIREBASE_URL');

  Map<String, Playlist> get listOfPlayLists => _listOfPlayLists;

  Future<void> addPlayList(Playlist playlist) async {
    try {
      final response = await http.post(Uri.parse('$_baseURL/playlists.json'),
          body: jsonEncode({
            'title': playlist.name,
            'description': playlist.description,
            'creation-date': playlist.creationDate,
            'movies': playlist.movieList,
          }));

      final id = jsonDecode(response.body)['name'];
      playlist.id = id;
      _listOfPlayLists[id] = playlist;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void removePlayList(Playlist playlist) {
    _listOfPlayLists
        .removeWhere((playlistKey, _) => playlistKey == playlist.id);
    notifyListeners();
  }

  Future<void> saveToPlaylist(String id, Movie movie) async {
    try {
      final selectedPlaylist = listOfPlayLists[id];

      selectedPlaylist!.addMovieToList(movie);

      final targetUrl = Uri.parse('$_baseURL/playlists/$id.json');

      await http.patch(targetUrl,
          body: jsonEncode({
            'movies': selectedPlaylist.movieList,
          }));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchPlaylists() async {
    final response = await http.get(
      Uri.parse('$_baseURL/playlists.json'),
    );
    final data = jsonDecode(response.body);

    for (var playlist in data.keys) {
      final loadedPlaylist = Playlist(
        id: playlist,
        name: data[playlist]['title'],
        description: data[playlist]['description'],
        creationDate: data[playlist]['creation-date'],
        movieList: getMovies(data[playlist]['movies']),
      );
      _listOfPlayLists[playlist] = loadedPlaylist;
    }
  }

  getMovies(data) {
    List<Movie> movies = [];

    for (var movie in data) {
      movies.add(Movie(
          id: movie['id'],
          title: movie['title'],
          fullTitle: movie['fullTitle'],
          crew: movie['crew'],
          rate: movie['rate'],
          year: movie['year'],
          imageUrl: movie['imageUrl'],
          plot: movie['plot'],
          releaseDate: movie['releaseDate'],
          directors: movie['directors']));
    }

    return movies;
  }
}
