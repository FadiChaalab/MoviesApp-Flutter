import 'package:movies/model/image.dart';

class ImageResponse {
  final List<ImageRequest> images;
  final String error;

  ImageResponse(this.images, this.error);

  ImageResponse.fromJson(Map<String, dynamic> json)
      : images = (json["stills"] as List)
            .map((i) => new ImageRequest.fromJson(i))
            .toList(),
        error = "";

  ImageResponse.withError(String errorValue)
      : images = List(),
        error = errorValue;
}
