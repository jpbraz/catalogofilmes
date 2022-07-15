import 'dart:convert';

import 'package:catalogo_filmes/models/user.dart';

import 'movie.dart';

class Rating {
  String id; // ID da avaliação
  Movie movie; // Movie selecionado
  double value; // Nota da Avaliação
  String? comment; // Comentários da avaliação
  UserApp userApp;

  Rating({
    required this.id,
    required this.movie,
    required this.value,
    this.comment,
    required this.userApp,
  });

  factory Rating.fromJson(String id, Map<String, dynamic> json) {
    Movie localMovie = Movie.fromJson(json['movie']['id'], json['movie']);
    UserApp localUserApp =
        UserApp.fromJson(json['userApp']['uid'], json['userApp']);

    return Rating(
      id: id,
      movie: localMovie,
      value: json['value'],
      comment: json['comment'],
      userApp: localUserApp,
    );
  }
}
