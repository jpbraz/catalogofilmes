import 'package:catalogo_filmes/components/movie_card.dart';
import 'package:catalogo_filmes/models/playlist.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class PlaylistDetailsScreen extends StatefulWidget {
  const PlaylistDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistDetailsScreen> createState() => _PlaylistDetailsScreenState();
}

class _PlaylistDetailsScreenState extends State<PlaylistDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final playlist = ModalRoute.of(context)!.settings.arguments as Playlist;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: Text(
              playlist.name,
            )),
        body: Container(
          padding: EdgeInsets.only(top: 10),
          color: Theme.of(context).colorScheme.primary,
          child: playlist.movieList!.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhum filme encontrado!',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: playlist.movieList!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              playlist.movieList![index].imageUrl)),
                      title: Text(
                        playlist.movieList![index].title,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              playlist.removeMovieFromList(
                                  playlist.movieList!.elementAt(index));
                            });
                          }),
                    );
                  }),
        ));
  }
}
