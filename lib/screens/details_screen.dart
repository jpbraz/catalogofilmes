import 'package:flutter/material.dart';
import '/models/movie.dart';
import '/models/genre.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class DetailsScreen extends StatefulWidget {
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List _items = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/my_genre_data.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)?.settings.arguments as Movie;
    String movieTitle = movie.title as String;
    String posterPath = movie.posterPath as String;
    String releaseDate = movie.releaseDate as String;
    String ano = releaseDate.substring(0, 4);
    String overview = movie.overview as String;
    double? rate = movie.voteAverage;
    int percentual = (rate! * 10).toInt();

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          floating: false,
          pinned: true,
          expandedHeight: 500,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              'https://image.tmdb.org/t/p/w220_and_h330_face$posterPath',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
              margin: const EdgeInsets.all(3),
              child: Row(
                children: [
                  Text("Ano de Lançamento - ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(ano, style: TextStyle(fontSize: 15))
                ],
              )),
          Container(
              margin: const EdgeInsets.all(3),
              child: Row(
                children: [
                  Text("Gênero: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(_items[0], style: TextStyle(fontSize: 15))
                ],
              )),
          Container(
            margin: const EdgeInsets.all(3),
            child: Text("Sinopse: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          Container(
            margin: const EdgeInsets.all(3),
            child:
                Expanded(child: Text(overview, style: TextStyle(fontSize: 15))),
          ),
          Container(
              margin: const EdgeInsets.all(3),
              child: Row(
                children: [
                  Text("Rating: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(rate.toString(), style: TextStyle(fontSize: 15))
                ],
              )),
        ]))
      ]),
    );
  }
}
