import 'package:movies/model/tv_detailed_model.dart';

class TvDetailResponse {
  final TvDetail tvDetail;
  final String error;

  TvDetailResponse(this.tvDetail, this.error);

  TvDetailResponse.fromJson(Map<String, dynamic> json)
      : tvDetail = TvDetail.fromJson(json),
        error = "";

  TvDetailResponse.withError(String errorValue)
      : tvDetail = TvDetail(
            null, null, null, null, "", null, "", "", "", null, null, null),
        error = errorValue;
}
