import 'package:flutter/material.dart';

import 'package:movie_aplication/src/providers/movies_provider.dart';
import 'package:movie_aplication/src/models/movie_model.dart';

class DataSearch extends SearchDelegate {
  final moviesProviders = new MoviesProvider();
  // final peliculas = [
  //   'Star Wars Episodio 1',
  //   'Star Wars Episodio 2',
  //   'Star Wars Episodio 3',
  //   'Star Wars Episodio 4',
  //   'Ironman 1',
  //   'Ironman 2',
  //   'Ironman 3',
  //   'Joker',
  //   'Ad Astra',
  //   'El irlandes',
  //   'Parásitos',
  //   'Zombieland 1',
  //   'Zombieland 2',
  //   'One Piece Estampida',
  //   '6 en la sombra'
  // ];

  // final peliulasSugeridas = ['6 en la sombra', 'Joker', 'Ad Astra'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados de la busqueda
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencias mediante la busqueda
    // final listaFinal = query.isEmpty
    //     ? peliulasSugeridas
    //     : peliculas
    //         .where(((p) => p.toLowerCase().startsWith(query.toLowerCase())))
    //         .toList();
    // return ListView.builder(
    //   itemCount: listaFinal.length,
    //   itemBuilder: (context, i) {
    //     return ListTile(
    //       leading: Icon(Icons.movie),
    //       title: Text(listaFinal[i]),
    //       onTap: () {},
    //     );
    //   },
    // );

    if (query.isEmpty) return Container();
    return FutureBuilder(
      future: moviesProviders.getSearshMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data.map((movie) {
              movie.uniqId = '';
              return ListTile(
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                leading: Hero(
                  tag: movie.uniqId,
                  child: FadeInImage(
                    image: NetworkImage(movie.getImagePost()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                    width: 50.0,
                  ),
                ),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, 'details', arguments: movie);
                },
              );
            }).toList(),
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
