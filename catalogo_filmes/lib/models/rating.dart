/* 
#13
Criar entidade para avaliação do filme com os atributos:

Comentário
Nota
Filme
*/

import 'dart:convert';

import 'movie.dart';

class Rating {
  String id; // ID da avaliação
  Movie movie; // Movie selecionado
  double value; // Nota da Avaliação
  String? comment; // Comentários da avaliação

  Rating({
    required this.id,
    required this.movie,
    required this.value,
    this.comment,
  });

  factory Rating.fromJson(String id, Map<String, dynamic> json) {
    Movie localMovie = Movie.fromJson(json['movie']['id'], json['movie']);

    return Rating(
      id: id,
      movie: localMovie,
      value: json['value'],
      comment: json['comment'],
    );
  }
}
