class Movies {
  List<Movie> items = new List();

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final movie = new Movie.fromJsonMap(item);

      items.add(movie);
    }
  }
}

class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap(Map<String, dynamic> response) {
    popularity = response['popularity'] / 1;
    voteCount = response['vote_count'];
    video = response['video'];
    posterPath = response['poster_path'];
    id = response['id'];
    adult = response['adult'];
    backdropPath = response['backdrop_path'];
    originalLanguage = response['original_language'];
    originalTitle = response['original_title'];
    genreIds = response['genre_ids'].cast<int>();
    title = response['title'];
    voteAverage = response['vote_average'] / 1;
    overview = response['overview'];
    releaseDate = response['release_date'];
  }
}
