import 'package:movies/model/episode.dart';

class EpisodeResponse {
  final List<Episode> episode;
  final String error;

  EpisodeResponse(this.episode, this.error);

  EpisodeResponse.fromJson(Map<String, dynamic> json)
      : episode = (json["results"] as List)
            .map((i) => new Episode.fromJson(i))
            .toList(),
        error = "";

  EpisodeResponse.withError(String errorValue)
      : episode = List(),
        error = errorValue;
}
