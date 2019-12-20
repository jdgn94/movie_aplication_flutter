import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_aplication/src/models/movie_model.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Movie> movies;

  CardSwiperWidget({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          movies[index].uniqId = '${movies[index].id}-card';
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              'details',
              arguments: movies[index],
            ),
            child: Hero(
              tag: movies[index].uniqId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                    image: NetworkImage(movies[index].getImagePost()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
          );
        },
        itemCount: movies.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.45,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
