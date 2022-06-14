import 'package:catalogo_filmes/components/drawer.dart';
import 'package:catalogo_filmes/providers/playlists_provider.dart';
import 'package:catalogo_filmes/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../components/edit_playlist.dart';

class PlaylistsScreen extends StatefulWidget {
  const PlaylistsScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistsScreen> createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  @override
  Widget build(BuildContext context) {
    var playlists = context.watch<PlayLists>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlists'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: playlists.listOfPlayLists.isEmpty
            ? const Center(
                child: Text(
                  'Nenhuma playlist criada!',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: playlists.listOfPlayLists.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
                    color: Theme.of(context).colorScheme.primary,
                    shadowColor: Colors.grey,
                    margin: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            AppRoutes.PLAYLIST_DETAILS,
                            arguments: playlists.listOfPlayLists.values
                                .elementAt(index));
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
                                  'criação: ${playlists.listOfPlayLists.values.elementAt(index).creationDate}',
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 10),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
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
                }),
      ),
      drawer: const MyMainDrawer(),
    );
  }
}
