import 'package:flutter/material.dart';

import 'package:movie_aplication/src/models/movie_model.dart';

class CardSwiperFooterWidget extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  CardSwiperFooterWidget({@required this.movies, @required this.nextPage});

  final _pageControler = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageControler.addListener(() {
      if (_pageControler.position.pixels >=
          _pageControler.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageControler,
        itemCount: movies.length,
        itemBuilder: (context, i) => _createCard(context, movies[i]),
        // children: _cards(context),
      ),
    );
  }

  Widget _createCard(BuildContext context, Movie movie) {
    movie.uniqId = '${movie.id}-footer';
    final card = Container(
      margin: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getImagePost()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }

  // esta tarjeta ya no se usa pero la dejo para futuras referencias
  List<Widget> _cards(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0, left: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(movie.getImagePost()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}
