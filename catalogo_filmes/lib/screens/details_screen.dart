import 'package:catalogo_filmes/providers/catalog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class DetailsScreen extends StatefulWidget {
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final Movie _movie;

  @override
  Widget build(BuildContext context) {
    _movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        opacity: 20,
                        image: NetworkImage(_movie.imageUrl),
                        fit: BoxFit.fill),
                  ),
                ),
                Positioned(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.black87,
                      child: Text(
                        _movie.title,
                        style: Theme.of(context).textTheme.headline2,
                      )),
                  bottom: 10,
                  left: 40,
                  right: 3,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            color: Theme.of(context).colorScheme.primary,
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Título Completo: ${_movie.title}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Ano: ${_movie.year}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Diretores: ${_movie.directors}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Elenco: ${_movie.crew}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nota IMDb: ${_movie.rate}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sinopse: ${_movie.plot}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
