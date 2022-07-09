import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '/models/playlist.dart';
import '/providers/playlists_provider.dart';

class NewPlaylist extends StatefulWidget {
  @override
  State<NewPlaylist> createState() => _NewPlaylistState();
}

class _NewPlaylistState extends State<NewPlaylist> {
  final _formData = <String, dynamic>{};
  final _formKey = GlobalKey<FormState>();

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    try {
      var newPlaylist = Playlist(
        id: Random().nextInt(2000).toString(),
        name: _formData['name'],
        description: _formData['description'],
        creationDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        movieList: [],
      );
      await Provider.of<PlayLists>(context, listen: false)
          .addPlayList(newPlaylist);
    } catch (error) {
      await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('An error occurred!'),
                content: const Text('Something went wrong.'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'))
                ],
              ));
    } finally {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 10),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: _formData['name']?.toString(),
                    decoration:
                        const InputDecoration(labelText: 'Playlist name'),
                    onSaved: (name) => _formData['name'] = name ?? '',
                    validator: (_name) {
                      final name = _name ?? '';

                      if (name.trim().isEmpty) {
                        return 'Name is required';
                      }

                      if (name.trim().length < 3) {
                        return 'The playlist name needs at least 3 characters.';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    onSaved: (description) =>
                        _formData['description'] = description ?? '',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: _submitForm, child: const Text('Confirm'))
                ],
              ))),
    );
  }
}
