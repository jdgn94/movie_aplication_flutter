import 'package:flutter/material.dart';

import 'package:movie_aplication/src/pages/home_page.dart';
import 'package:movie_aplication/src/pages/movie_details_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'details': (BuildContext context) => MovieDetailsPage(),
      },
    );
  }
}
