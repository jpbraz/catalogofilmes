import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/playlists_provider.dart';
import '../../utils/app_routes.dart';
import 'edit_playlist.dart';

class PlaylistList extends StatefulWidget {
  @override
  State<PlaylistList> createState() => _PlaylistListState();
}

class _PlaylistListState extends State<PlaylistList> {
  @override
  Widget build(BuildContext context) {
    var playlists = context.watch<PlayLists>();

    return ListView.builder(
        itemCount: playlists.listOfPlayLists.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1,
            color: Theme.of(context).colorScheme.primary,
            shadowColor: Colors.grey,
            margin: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.PLAYLIST_DETAILS,
                    arguments:
                        playlists.listOfPlayLists.values.elementAt(index));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          playlists.listOfPlayLists.values
                              .elementAt(index)
                              .name,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          'creation: ${playlists.listOfPlayLists.values.elementAt(index).creationDate}',
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return EditPlaylist(playlists
                                      .listOfPlayLists.values
                                      .elementAt(index));
                                }).then((_) => setState((() {})));
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              playlists.removePlayList(playlists
                                  .listOfPlayLists.values
                                  .elementAt(index));
                            });
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
