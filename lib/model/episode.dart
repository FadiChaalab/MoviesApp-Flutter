class Episode {
  final int id;
  final String title;
  final String poster;
  final String overview;
  final String release;
  final rating;
  final count;
  final String productionCode;
  final int showId;
  final int episodeNumber;
  final int seasonNumber;

  Episode(
    this.id,
    this.title,
    this.poster,
    this.overview,
    this.release,
    this.rating,
    this.count,
    this.productionCode,
    this.showId,
    this.episodeNumber,
    this.seasonNumber,
  );

  Episode.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["name"],
        poster = json["still_path"],
        overview = json["overview"],
        release = json["air_date"],
        rating = json["vote_average"].toDouble(),
        count = json["vote_count"].toDouble(),
        productionCode = json["production_code"],
        showId = json["show_id"],
        episodeNumber = json["episode_number"],
        seasonNumber = json["season_number"];
}
