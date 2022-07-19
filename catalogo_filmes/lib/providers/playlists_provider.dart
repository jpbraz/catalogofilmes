import 'package:catalogo_filmes/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/movie.dart';
import '../models/playlist.dart';

class PlayLists with ChangeNotifier {
  final Map<String, Playlist> _listOfPlayLists = {};
  final _baseURL = dotenv.get('FIREBASE_URL');
  final DatabaseReference _databasePlaylistsRef =
      FirebaseDatabase.instance.ref('/playlists');
  Map<String, Playlist> get listOfPlayLists => _listOfPlayLists;

  Future<void> addPlayList(Playlist playlist) async {
    try {
      DatabaseReference newPlaylistRef = _databasePlaylistsRef.push();

      await newPlaylistRef.set(playlist.toJson());
      await newPlaylistRef.update({'id': newPlaylistRef.key});

      final id = newPlaylistRef.key;
      playlist.id = id.toString();
      _listOfPlayLists[id.toString()] = playlist;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> removePlayList(Playlist playlist) async {
    final response =
        await http.delete(Uri.parse('$_baseURL/playlists/${playlist.id}.json'));
    if (response.statusCode >= 400) {
      throw 'Erro ao remover playlist';
    }

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
            'movieList': selectedPlaylist.movieList,
          }));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updatePlaylist(Playlist playlist) async {
    try {
      final playlistId = playlist.id;

      final targetUrl = Uri.parse('$_baseURL/playlists/$playlistId.json');

      await http.patch(targetUrl,
          body: jsonEncode({
            'title': playlist.name,
            'description': playlist.description,
            'movies': playlist.movieList,
          }));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchPlaylists() async {
    final user = AuthService().auth.currentUser!;
    _listOfPlayLists.clear();

    try {
      final snapshot = await _databasePlaylistsRef.get();

      if (snapshot.exists) {
        final data = jsonDecode(jsonEncode(snapshot.value));

        data.forEach((key, value) {
          if (value['userID'] == user.uid) {
            final playlist = Playlist.fromJson(value['id'] as String, value);
            _listOfPlayLists[playlist.id] = playlist;
          }
        });
        debugPrint('[INFO]: ${_listOfPlayLists.length} Playlists loaded');
      } else {
        debugPrint("[fetchPlaylist] no playlists found");
      }
    } catch (error) {
      rethrow;
    }
  }

  getMovies(data) {
    List<Movie> movies = [];

    if (data == null) {
      return movies;
    }

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
