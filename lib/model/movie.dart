class Movie {
  final int id;
  final popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final rating;

  Movie(this.id, this.popularity, this.title, this.backPoster, this.poster,
      this.overview, this.rating);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        title = json["title"],
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating = json["vote_average"];
}
