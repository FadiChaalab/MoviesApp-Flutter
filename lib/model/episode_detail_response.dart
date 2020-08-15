import 'package:movies/model/episode_detail.dart';

class EpisodeDetailResponse {
  final EpisodeDetail episodeDetail;
  final String error;

  EpisodeDetailResponse(this.episodeDetail, this.error);

  EpisodeDetailResponse.fromJson(Map<String, dynamic> json)
      : episodeDetail = EpisodeDetail.fromJson(json),
        error = "";

  EpisodeDetailResponse.withError(String errorValue)
      : episodeDetail = EpisodeDetail(null, null),
        error = errorValue;
}
