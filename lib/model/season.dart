class Season {
  final int id;
  final String title;
  final String poster;
  final String overview;
  final String release;
  final int seasonNumber;
  final int numberOfEpisodes;

  Season(
    this.id,
    this.title,
    this.poster,
    this.overview,
    this.release,
    this.seasonNumber,
    this.numberOfEpisodes,
  );

  Season.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["name"],
        poster = json["poster_path"],
        overview = json["overview"],
        release = json["air_date"],
        seasonNumber = json["season_number"],
        numberOfEpisodes = json["episode_count"];
}
