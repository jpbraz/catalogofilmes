import 'package:catalogo_filmes/models/rating.dart';

class Movie {
  String id;
  String title;
  String fullTitle;
  String crew;
  String rate;
  String year;
  String imageUrl;
  String? releaseDate;
  String? runTimeStr;
  String? plot;
  String? directors;
  List<Rating>? ratings;

  Movie({
    required this.id,
    required this.title,
    required this.fullTitle,
    required this.crew,
    required this.rate,
    required this.year,
    required this.imageUrl,
    this.plot,
    this.runTimeStr,
    this.releaseDate,
    this.directors,
    this.ratings,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'fullTitle': fullTitle,
      'crew': crew,
      'rate': rate,
      'year': year,
      'imageUrl': imageUrl,
      'plot': plot,
      'releaseDate': releaseDate,
      'runTimeStr': runTimeStr,
      'directors': directors,
    };
  }

  factory Movie.fromJson(String id, Map json) {
    return Movie(
      id: id,
      title: json['title'],
      fullTitle: json['fullTitle'],
      crew: json['crew'],
      rate: json['rate'],
      year: json['year'],
      imageUrl: json['imageUrl'],
      releaseDate: json['releaseDate'],
      runTimeStr: json['runTimeStr'],
      plot: json['plot'],
      directors: json['directors'],
    );
  }
}
