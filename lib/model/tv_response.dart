import 'package:movies/model/tv.dart';

class TvShowsResponse {
  final List<TvShows> tvShows;
  final String error;

  TvShowsResponse(this.tvShows, this.error);

  TvShowsResponse.fromJson(Map<String, dynamic> json)
      : tvShows = (json["results"] as List)
            .map((i) => new TvShows.fromJson(i))
            .toList(),
        error = "";

  TvShowsResponse.withError(String errorValue)
      : tvShows = List(),
        error = errorValue;
}
