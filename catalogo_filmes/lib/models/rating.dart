import 'package:catalogo_filmes/models/user.dart';

class Rating {
  String id; // ID da avaliação
  double value; // Nota da Avaliação
  String? comment; // Comentários da avaliação
  UserApp userApp;

  Rating({
    required this.id,
    required this.value,
    this.comment,
    required this.userApp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'comment': comment,
      'userApp': userApp.toJson(),
    };
  }

  factory Rating.fromJson(String id, Map<String, dynamic> json) {
    UserApp localUserApp =
        UserApp.fromJson(json['userApp']['uid'], json['userApp']);

    return Rating(
      id: id,
      value: json['value'],
      comment: json['comment'],
      userApp: localUserApp,
    );
  }
}
