import 'dart:math';

import 'package:catalogo_filmes/models/playlist.dart';
import 'package:catalogo_filmes/providers/playlists_provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
          creationDate: DateFormat('dd-MM-yyyy').format(DateTime.now()));
      await Provider.of<PlayLists>(context, listen: false)
          .addPlayList(newPlaylist);
    } catch (error) {
      await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Ocorreu um erro!'),
                content: Text('Algo deu errado.'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Fechar'))
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
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _formData['name']?.toString(),
                    decoration:
                        const InputDecoration(labelText: 'Nome da playlist'),
                    onSaved: (name) => _formData['name'] = name ?? '',
                    validator: (_name) {
                      final name = _name ?? '';

                      if (name.trim().isEmpty) {
                        return 'Nome é obrigatório';
                      }

                      if (name.trim().length < 3) {
                        return 'Nome precisa no mínimo de 3 letras.';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                    ),
                    onSaved: (description) =>
                        _formData['description'] = description ?? '',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: _submitForm, child: Text('Confirmar'))
                ],
              ))),
    );
  }
}
