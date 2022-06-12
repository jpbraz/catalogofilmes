/*
#12 - Criar entidade de lista de filmes com seguintes atributos:

Nome
Lista de filmes
Data de criação
Descrição
*/

import 'dart:convert';

import 'movie.dart';

class Playlist {
  String id;
  String name;
  String creationDate;
  String? description;
  List<Movie>? movieList;

  Playlist({
    required this.id,
    required this.name,
    required this.creationDate,
    this.description,
    this.movieList,
  });

  addMovieToList(Movie movie) {
    movieList?.add(movie);
  }

  removeMovieFromList(Movie movie) {
    movieList?.remove(movie);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.name,
      'creation-date': this.creationDate,
      'description': this.description,
      'movies': movieList != null
          ? movieList!.map((movie) => movie.toJson()).toList()
          : []
    };
  }
}
