class Credits {
  final String id;
  final String character;
  final String name;
  final String img;

  Credits(this.id, this.character, this.name, this.img);

  Credits.fromJson(Map<String, dynamic> json)
      : id = json["credit_id"],
        character = json["character"],
        name = json["name"],
        img = json["profile_path"];
}
