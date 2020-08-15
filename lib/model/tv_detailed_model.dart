import 'package:movies/model/company.dart';
import 'package:movies/model/genre.dart';
import 'package:movies/model/season.dart';

class TvDetail {
  final int id;
  final List<Genre> genres;
  final List<Company> companies;
  final List<Season> seasons;
  final String releaseDate;
  final List runtime;
  final String firstAirDate;
  final String lastAirDate;
  final String nextEpisodeAirDate;
  final int numberOfSeason;
  final int numberOfEpisode;
  final String status;

  TvDetail(
      this.id,
      this.genres,
      this.companies,
      this.seasons,
      this.releaseDate,
      this.runtime,
      this.firstAirDate,
      this.lastAirDate,
      this.nextEpisodeAirDate,
      this.numberOfSeason,
      this.numberOfEpisode,
      this.status);

  TvDetail.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        genres =
            (json["genres"] as List).map((i) => new Genre.fromJson(i)).toList(),
        companies = (json["production_companies"] as List)
            .map((i) => new Company.fromJson(i))
            .toList(),
        seasons = (json["seasons"] as List)
            .map((i) => new Season.fromJson(i))
            .toList(),
        releaseDate = json["release_date"],
        runtime = json["episode_run_time"],
        firstAirDate = json["first_air_date"],
        lastAirDate = json["last_air_date"],
        nextEpisodeAirDate = json["next_episode_to_air"],
        numberOfSeason = json["number_of_seasons"],
        numberOfEpisode = json["number_of_episodes"],
        status = json["status"];
}
