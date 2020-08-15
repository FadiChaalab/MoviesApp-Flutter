import 'package:flutter/material.dart';
import 'package:movies/model/video_response.dart';
import 'package:movies/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class EpisodeVideoBloc {
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<VideoResponse> _subject =
      BehaviorSubject<VideoResponse>();

  getEpisodeVideos(int id, int season, int episode) async {
    VideoResponse response =
        await _repository.getEpisodeVideos(id, season, episode);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<VideoResponse> get subject => _subject;
}

final episodeVideoBloc = EpisodeVideoBloc();
