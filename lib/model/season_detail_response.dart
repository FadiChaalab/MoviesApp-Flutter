import 'package:movies/model/season_detail.dart';

class SeasonDetailResponse {
  final SeasonDetail seasonDetail;
  final String error;

  SeasonDetailResponse(this.seasonDetail, this.error);

  SeasonDetailResponse.fromJson(Map<String, dynamic> json)
      : seasonDetail = SeasonDetail.fromJson(json),
        error = "";

  SeasonDetailResponse.withError(String errorValue)
      : seasonDetail = SeasonDetail("", null, ""),
        error = errorValue;
}
