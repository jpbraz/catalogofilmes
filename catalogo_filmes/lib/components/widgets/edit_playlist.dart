import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/playlist.dart';
import '../../providers/playlists_provider.dart';

class EditPlaylist extends StatefulWidget {
  Playlist playlist;

  EditPlaylist(this.playlist);

  @override
  State<EditPlaylist> createState() => _EditPlaylistState();
}

class _EditPlaylistState extends State<EditPlaylist> {
  final _formData = <String, dynamic>{};
  final _formKey = GlobalKey<FormState>();

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    try {
      setState(() {
        widget.playlist.name = _formData['name'];
        widget.playlist.description = _formData['description'];
      });
      await Provider.of<PlayLists>(context, listen: false)
          .updatePlaylist(widget.playlist);
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
  void initState() {
    _formData['name'] = widget.playlist.name;
    _formData['description'] = widget.playlist.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: _formData['name'],
                    decoration:
                        const InputDecoration(labelText: 'Playlist name'),
                    onSaved: (name) => _formData['name'] = name ?? '',
                    validator: (_name) {
                      final name = _name ?? '';

                      if (name.trim().isEmpty) {
                        return 'Name is required';
                      }

                      if (name.trim().length < 3) {
                        return 'The playlist name needs at least 3 characters';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _formData['description'],
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
                      onPressed: _submitForm, child: const Text('Update'))
                ],
              ))),
    );
  }
}
