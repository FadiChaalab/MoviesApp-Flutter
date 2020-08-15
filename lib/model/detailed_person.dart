class DetailedPerson {
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String known;
  final String birthday;
  final List knownAs;
  final int gender;
  final String biography;
  final String placeOfBirth;
  final bool adult;

  DetailedPerson(
      this.id,
      this.popularity,
      this.name,
      this.profileImg,
      this.known,
      this.birthday,
      this.knownAs,
      this.gender,
      this.biography,
      this.placeOfBirth,
      this.adult);

  DetailedPerson.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        name = json["name"],
        profileImg = json["profile_path"],
        known = json["known_for_department"],
        birthday = json["birthday"],
        knownAs = json["also_known_as"],
        gender = json["gender"],
        biography = json["biography"],
        placeOfBirth = json["place_of_birth"],
        adult = json["adult"];
}
