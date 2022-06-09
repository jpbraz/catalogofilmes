/* 
#13
Criar entidade para avaliação do filme com os atributos:

Comentário
Nota
Filme
*/

class Rating {
  String id; // ID da avaliação
  String movieId; // ID do movie selecionado
  double value; // Nota da Avaliação
  String? comments; // Comentários da avaliação

  Rating({
    required this.id,
    required this.movieId,
    required this.value,
    this.comments,
  });

/*
  void update(Rating rating) {
    if (this == rating) {
      movieId = rating.movieId;
      value = rating.value;
      comments = rating.comments;
    }
  }
*/
}
