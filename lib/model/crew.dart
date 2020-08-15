class Crew {
  final int id;
  final String credit;
  final String name;
  final String img;
  final String department;
  final String job;

  Crew(this.id, this.credit, this.name, this.img, this.department, this.job);

  Crew.fromJson(Map<String, dynamic> json)
      : id = json["cast_id"],
        credit = json["credit_id"],
        name = json["name"],
        img = json["profile_path"],
        department = json["department"],
        job = json["job"];
}
