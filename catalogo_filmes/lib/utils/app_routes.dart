import 'package:flutter/material.dart';

class AppRoutes {
  static const STARTPAGE = '/startpage';
  static const CATALOG = '/catalog';
  static const DETAILS = '/details';
  static const FAVORITES = '/favorites';
  static const PLAYLISTS = '/playlists-screen';
  static const PLAYLIST_DETAILS = '/playlist-details-screen';
  static const MOVIE_DETAILS = '/movie-details-screen';
  static const NOTIFICATIONS = '/notifications-screen';
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
