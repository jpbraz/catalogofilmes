import 'package:flutter/material.dart';

import '../../controller/firebaseController.dart';
import '../../models/movie.dart';
import '../../models/rating.dart';

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

    if (editMode) {
      rating = widget.rating!;

      _formData['id'] = rating.id;
      _formData['movie'] = movie;
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
        _formData['movie'] = movie;
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
      padding: EdgeInsets.fromLTRB(
          15, 15, 15, (MediaQuery.of(context).viewInsets.bottom + 10)),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              movie.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ),
            TextFormField(
              initialValue: _formData['value']?.toString(),
              decoration: const InputDecoration(labelText: 'Rate'),
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
                  return 'Insert a value between 0 and 10.';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _formData['comment']?.toString(),
              decoration: const InputDecoration(labelText: 'Commentary'),
              focusNode: _ratingCommentFocus,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              onSaved: (comment) => _formData['comment'] = comment ?? '',
              validator: (_comment) {
                final comment = _comment ?? '';
                if (comment.trim().length > 255) {
                  return 'Commentary max lenght is 255 characters';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: _submitForm,
                child: editMode ? const Text('Update') : const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
