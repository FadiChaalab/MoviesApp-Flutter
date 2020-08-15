import 'package:movies/model/crew.dart';
import 'package:movies/model/guest.dart';

class EpisodeDetail {
  final List<Crew> crew;
  final List<Guest> guests;

  EpisodeDetail(this.crew, this.guests);

  EpisodeDetail.fromJson(Map<String, dynamic> json)
      : crew = (json["crew"] as List).map((c) => new Crew.fromJson(c)).toList(),
        guests = (json["guest_stars"] as List)
            .map((c) => new Guest.fromJson(c))
            .toList();
}
