class Guest {
  final int id;
  final String credit;
  final String name;
  final String img;
  final String character;
  final int order;

  Guest(this.id, this.credit, this.name, this.img, this.character, this.order);

  Guest.fromJson(Map<String, dynamic> json)
      : id = json["cast_id"],
        credit = json["credit_id"],
        name = json["name"],
        img = json["profile_path"],
        character = json["character"],
        order = json["order"];
}
