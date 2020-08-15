import 'package:flutter/material.dart';
import 'package:movies/model/image_response.dart';
import 'package:movies/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class EpisodeImageBloc {
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<ImageResponse> _subject =
      BehaviorSubject<ImageResponse>();

  getEpisodeImages(int id, int season, int episode) async {
    ImageResponse response =
        await _repository.getEpisodeImages(id, season, episode);
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

  BehaviorSubject<ImageResponse> get subject => _subject;
}

final episodeImageBloc = EpisodeImageBloc();
