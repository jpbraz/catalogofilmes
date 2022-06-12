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
}
