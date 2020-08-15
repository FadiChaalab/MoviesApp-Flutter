import 'package:dio/dio.dart';
import 'package:movies/model/Credits_response.dart';
import 'package:movies/model/episode_detail_response.dart';
import 'package:movies/model/genre_response.dart';
import 'package:movies/model/image_response.dart';
import 'package:movies/model/season_detail_response.dart';
import 'package:movies/model/tv_detailed_responce.dart';
import 'package:movies/model/tv_response.dart';
import 'package:movies/model/video_response.dart';

class TvRepository {
  final String apiKey = "bd84a6a577a7f546e04638e46bbf1aa3";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/tv/top_rated';
  var getTvShowsUrl = '$mainUrl/discover/tv';
  var getGenresUrl = "$mainUrl/genre/tv/list";
  var tvUrl = "$mainUrl/tv";
  var getPopularTvUrl = '$mainUrl/tv/popular';

  Future<TvShowsResponse> getTvShows() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return TvShowsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvShowsResponse.withError("$error");
    }
  }

  Future<TvShowsResponse> getPopularTvShows() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPopularTvUrl, queryParameters: params);
      return TvShowsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvShowsResponse.withError("$error");
    }
  }

  Future<TvShowsResponse> getDiscoverTv() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getTvShowsUrl, queryParameters: params);
      return TvShowsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvShowsResponse.withError("$error");
    }
  }

  Future<GenreResponse> getTvGenres() async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GenreResponse.withError("$error");
    }
  }

  Future<TvShowsResponse> getTvShowsByGenre(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page": 1,
      "with_genres": id
    };
    try {
      Response response =
          await _dio.get(getTvShowsUrl, queryParameters: params);
      return TvShowsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvShowsResponse.withError("$error");
    }
  }

  Future<TvDetailResponse> getTvDetail(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response =
          await _dio.get(tvUrl + "/$id", queryParameters: params);
      return TvDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvDetailResponse.withError("$error");
    }
  }

  Future<SeasonDetailResponse> getSeasonDetail(int id, int number) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(tvUrl + "/$id/season/$number",
          queryParameters: params);
      return SeasonDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return SeasonDetailResponse.withError("$error");
    }
  }

  Future<EpisodeDetailResponse> getEpisodeDetail(
      int id, int number, int episode) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(
          tvUrl + "/$id/season/$number/episode/$episode",
          queryParameters: params);
      return EpisodeDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return EpisodeDetailResponse.withError("$error");
    }
  }

  Future<TvShowsResponse> getSearchedTv(String query) async {
    try {
      Response response = await _dio.get(
          "https://api.themoviedb.org/3/search/tv?api_key=$apiKey&language=en-US&query=$query&include_adult=false");
      return TvShowsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvShowsResponse.withError("$error");
    }
  }

  Future<CreditResponse> getCasts(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response =
          await _dio.get(tvUrl + "/$id" + "/credits", queryParameters: params);
      return CreditResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CreditResponse.withError("$error");
    }
  }

  Future<VideoResponse> getTvVideos(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response =
          await _dio.get(tvUrl + "/$id" + "/videos", queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }

  Future<VideoResponse> getEpisodeVideos(
      int id, int season, int episode) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(
          tvUrl + "/$id/season/$season/episode/$episode" + "/videos",
          queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }

  Future<ImageResponse> getEpisodeImages(
      int id, int season, int episode) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(
          tvUrl + "/$id/season/$season/episode/$episode" + "/images",
          queryParameters: params);
      return ImageResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ImageResponse.withError("$error");
    }
  }

  Future<TvShowsResponse> getSimilarTvs(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response =
          await _dio.get(tvUrl + "/$id" + "/similar", queryParameters: params);
      return TvShowsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvShowsResponse.withError("$error");
    }
  }

  Future<TvShowsResponse> getRecommendationTvs(int id) async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(tvUrl + "/$id" + "/recommendations",
          queryParameters: params);
      return TvShowsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvShowsResponse.withError("$error");
    }
  }
}
