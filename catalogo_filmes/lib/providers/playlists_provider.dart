import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
}
