import 'package:flutter/material.dart';

import 'package:movie_aplication/src/widgets/card_swiper_widget.dart';
import 'package:movie_aplication/src/providers/movies_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperCards(),
          ],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    final moviesProvider = new MoviesProvider();
    moviesProvider.getNowPlaying();

    return CardSwiperWidget(movies: [1, 2, 3, 4, 5]);
    // return Container();
  }
}
