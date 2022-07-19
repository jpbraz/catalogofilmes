import 'package:catalogo_filmes/components/navigation/drawer.dart';
import 'package:catalogo_filmes/components/widgets/playlists_list.dart';
import 'package:catalogo_filmes/providers/playlists_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaylistsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlists'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Consumer<PlayLists>(
        builder: ((context, playlists, child) {
          return Container(
              color: Theme.of(context).colorScheme.primary,
              child: playlists.listOfPlayLists.isEmpty
                  ? const Center(
                      child: Text(
                        'You dont have any playlist!',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    )
                  : PlaylistList());
        }),
      ),
      drawer: MyMainDrawer(),
    );
  }
}
