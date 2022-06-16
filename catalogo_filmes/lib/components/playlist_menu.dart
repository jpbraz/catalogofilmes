import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/playlists_provider.dart';

class PlaylistMenuDialog extends StatefulWidget {
  String _dropDownValue;
  final Movie _movie;

  PlaylistMenuDialog(this._dropDownValue, this._movie);
  @override
  State<PlaylistMenuDialog> createState() => _PlaylistMenuDialogState();
}

class _PlaylistMenuDialogState extends State<PlaylistMenuDialog> {
  @override
  Widget build(BuildContext context) {
    var playlists = context.watch<PlayLists>();

    if (playlists.listOfPlayLists.isNotEmpty &&
        widget._dropDownValue == 'playlists') {
      widget._dropDownValue = playlists.listOfPlayLists.values.first.id;
    }
    return AlertDialog(
      title: const Text('Choose the playlist'),
      content: DropdownButton(
          value: widget._dropDownValue,
          items: playlists.listOfPlayLists.values
              .map((playlist) => DropdownMenuItem(
                    child: Text(playlist.name.toUpperCase()),
                    value: playlist.id,
                  ))
              .toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget._dropDownValue = newValue!;
            });
          }),
      actions: [
        ElevatedButton(
            onPressed: () async {
              try {
                await playlists.saveToPlaylist(
                    widget._dropDownValue, widget._movie);
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
            },
            child: const Text('Confirm'))
      ],
    );
  }
}
