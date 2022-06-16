import 'package:catalogo_filmes/components/movie_info.dart';
import 'package:catalogo_filmes/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie _movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return SafeArea(
      child: Scaffold(
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
                        padding: const EdgeInsets.all(10),
                        color: Colors.black87,
                        child: Text(
                          _movie.title,
                          style: Theme.of(context).textTheme.headline2,
                        )),
                    bottom: 10,
                    left: 40,
                    right: 3,
                  ),
                  Positioned(
                    top: 0,
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
                  )
                ],
              ),
            ),
            Expanded(child: MovieInfo(_movie))
          ],
        ),
      ),
    );
  }
}
