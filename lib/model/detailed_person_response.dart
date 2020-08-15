import 'package:movies/model/detailed_person.dart';

class PersonDetailResponse {
  final DetailedPerson personDetail;
  final String error;

  PersonDetailResponse(this.personDetail, this.error);

  PersonDetailResponse.fromJson(Map<String, dynamic> json)
      : personDetail = DetailedPerson.fromJson(json),
        error = "";

  PersonDetailResponse.withError(String errorValue)
      : personDetail = DetailedPerson(
            null, null, "", "", "", "", null, null, "", null, null),
        error = errorValue;
}
