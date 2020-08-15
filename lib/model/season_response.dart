import 'package:movies/model/season.dart';

class SeasonResponse {
  final List<Season> season;
  final String error;

  SeasonResponse(this.season, this.error);

  SeasonResponse.fromJson(Map<String, dynamic> json)
      : season = (json["results"] as List)
            .map((i) => new Season.fromJson(i))
            .toList(),
        error = "";

  SeasonResponse.withError(String errorValue)
      : season = List(),
        error = errorValue;
}
