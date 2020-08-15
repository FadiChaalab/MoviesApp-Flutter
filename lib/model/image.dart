class ImageRequest {
  final double radio;
  final String img;
  final int height;
  final int width;
  final popularity;
  final count;

  ImageRequest(this.radio, this.img, this.height, this.width, this.popularity,
      this.count);

  ImageRequest.fromJson(Map<String, dynamic> json)
      : radio = json["aspect_ratio"],
        img = json["file_path"],
        height = json["height"],
        width = json["width"],
        popularity = json["vote_average"],
        count = json["vote_count"];
}
