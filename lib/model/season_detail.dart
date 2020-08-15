import 'package:movies/model/episode.dart';

class SeasonDetail {
  final String id;
  final List<Episode> episodes;
  final String release;

  SeasonDetail(this.id, this.episodes, this.release);

  SeasonDetail.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        episodes = (json["episodes"] as List)
            .map((i) => new Episode.fromJson(i))
            .toList(),
        release = json["air_date"];
}
