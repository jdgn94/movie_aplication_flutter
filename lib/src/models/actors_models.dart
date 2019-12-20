class Casting {
  List<Cast> items = new List();

  Casting();

  Casting.fromJsonMap(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final cast = Cast.fromJsonMap(item);
      items.add(cast);
    });
  }
}

class Cast {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Cast({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Cast.fromJsonMap(Map<String, dynamic> response) {
    castId = response['cast_id'];
    character = response['character'];
    creditId = response['credit_id'];
    gender = response['gender'];
    id = response['id'];
    name = response['name'];
    order = response['order'];
    profilePath = response['profile_path'];
  }

  getPhoto() {
    if (profilePath == null)
      return 'http://www.aldeatonantzin.com/wp-content/uploads/2017/08/placeholderImage.png';
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
