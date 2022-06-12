import 'package:catalogo_filmes/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

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
                        image: NetworkImage(movie.imageUrl),
                        fit: BoxFit.fill),
                  ),
                ),
                Positioned(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.black87,
                      child: Text(
                        movie.title,
                        style: Theme.of(context).textTheme.headline2,
                      )),
                  bottom: 10,
                  left: 40,
                  right: 3,
                ),
                Positioned(
                  child: Container(
                    color: Colors.black45,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 30,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  top: 0,
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            color: Theme.of(context).colorScheme.primary,
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Título Completo: ${movie.title}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Ano: ${movie.year}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Diretores: ${movie.directors}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Elenco: ${movie.crew}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nota IMDb: ${movie.rate}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sinopse: ${movie.plot}',
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
