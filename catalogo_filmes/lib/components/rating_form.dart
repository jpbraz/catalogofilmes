import 'package:catalogo_filmes/components/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/firebaseController.dart';
import '../models/movie.dart';
import '../models/rating.dart';

class RatingForm extends StatefulWidget {
  final Movie movie;
  final Rating? rating;
  const RatingForm({Key? key, required this.movie, this.rating})
      : super(key: key);

  @override
  State<RatingForm> createState() => _RatingFormState();
}

class _RatingFormState extends State<RatingForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  final _ratingValueFocus = FocusNode();
  final _ratingCommentFocus = FocusNode();

  bool get editMode => widget.rating != null;

  late Movie movie;
  late Rating rating;

  @override
  void initState() {
    super.initState();
    movie = widget.movie;
    print("Rating para o movie: ${movie.title}");
    if (editMode) {
      rating = widget.rating!;

      print("Editando a avaliação de ID: ${rating.id}");
      _formData['id'] = rating.id;
      _formData['movie'] = rating.movie;
      _formData['value'] = rating.value;
      _formData['comment'] = rating.comment!;
    } else {
      _formData['movie'] = movie;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final rating = arg as Rating;
        _formData['id'] = rating.id;
        _formData['movie'] = rating.movie;
        _formData['value'] = rating.value;
        _formData['comment'] = rating.comment!;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _ratingValueFocus.dispose();
    _ratingCommentFocus.dispose();
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      print("Formulário invélido");
      return;
    }

    _formKey.currentState?.save();

    FirebaseController()
        .saveRatingForm(_formData)
        .then((_) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Expanded(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _formData['value']?.toString(),
                      decoration: const InputDecoration(labelText: 'Nota'),
                      textInputAction: TextInputAction.next,
                      focusNode: _ratingValueFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_ratingValueFocus);
                      },
                      onSaved: (value) =>
                          _formData['value'] = double.parse(value ?? '0'),
                      validator: (_value) {
                        final valueString = _value ?? '';
                        final value = double.tryParse(valueString) ?? -1;

                        if (value < 0 || value > 10) {
                          return 'Informe uma nota entre 0 e 10.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['comment']?.toString(),
                      decoration:
                          const InputDecoration(labelText: 'Comentário'),
                      focusNode: _ratingCommentFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (comment) =>
                          _formData['comment'] = comment ?? '',
                      validator: (_comment) {
                        final comment = _comment ?? '';
                        if (comment.trim().length < 5) {
                          return 'Comentário precisa no mínimo de 5 letras.';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                child:
                    editMode ? const Text('Atualizar') : const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
