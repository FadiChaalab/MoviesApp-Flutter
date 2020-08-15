class TvShows {
  final int id;
  final popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final rating;
  final count;
  final String release;

  TvShows(
    this.id,
    this.popularity,
    this.title,
    this.backPoster,
    this.poster,
    this.overview,
    this.rating,
    this.count,
    this.release,
  );

  TvShows.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        title = json["name"],
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating = json["vote_average"],
        count = json["vote_count"],
        release = json["first_air_date"];
}
