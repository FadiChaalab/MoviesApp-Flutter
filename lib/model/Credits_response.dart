import 'package:movies/model/credits.dart';

class CreditResponse {
  final List<Credits> credits;
  final String error;

  CreditResponse(this.credits, this.error);

  CreditResponse.fromJson(Map<String, dynamic> json)
      : credits =
            (json["cast"] as List).map((i) => new Credits.fromJson(i)).toList(),
        error = "";

  CreditResponse.withError(String errorValue)
      : credits = List(),
        error = errorValue;
}
