import 'dart:convert';

import 'package:movie_aplication/src/models/movie_model.dart';

import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = 'e03263cb40f8f86bad9ac4d2fe50abfd';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }
}
