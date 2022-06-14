import 'dart:math';

import 'package:catalogo_filmes/models/playlist.dart';
import 'package:catalogo_filmes/providers/playlists_provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
                title: const Text('Ocorreu um erro!'),
                content: const Text('Algo deu errado.'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Fechar'))
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
                children: [
                  TextFormField(
                    initialValue: _formData['name'],
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
                    initialValue: _formData['description'],
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
                      onPressed: _submitForm, child: const Text('Atualizar'))
                ],
              ))),
    );
  }
}
