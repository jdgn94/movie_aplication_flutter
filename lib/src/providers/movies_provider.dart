import 'dart:convert';
import 'dart:async';

import 'package:movie_aplication/src/models/actors_models.dart';
import 'package:movie_aplication/src/models/movie_model.dart';

import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = 'e03263cb40f8f86bad9ac4d2fe50abfd';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularsPage = 0;

  bool _loading = false;

  List<Movie> _populars = new List();

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _procesingResponse(Uri url) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _procesingResponse(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_loading) return [];

    _loading = true;
    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString(),
    });

    final response = await _procesingResponse(url);

    _populars.addAll(response);
    popularsSink(_populars);

    _loading = false;
    return response;
  }

  Future<List<Cast>> getCasts(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final casting = new Casting.fromJsonMap(decodeData['cast']);

    return casting.items;
  }

  Future<List<Movie>> getSearshMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    return await _procesingResponse(url);
  }
}
