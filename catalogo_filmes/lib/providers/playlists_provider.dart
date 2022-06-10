import 'package:flutter/cupertino.dart';

import '../models/playlist.dart';

class PlayLists with ChangeNotifier {
  final Map<String, Playlist> _listOfPlayLists = {};

  Map<String, Playlist> get listOfPlayLists => _listOfPlayLists;

  void addPlayList(Playlist playlist) {
    _listOfPlayLists.putIfAbsent(playlist.id, () => playlist);
    notifyListeners();
  }

  void removePlayList(Playlist playlist) {
    _listOfPlayLists
        .removeWhere((playlistKey, _) => playlistKey == playlist.id);
    notifyListeners();
  }
}
