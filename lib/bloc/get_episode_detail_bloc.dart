import 'package:flutter/material.dart';
import 'package:movies/model/episode_detail_response.dart';
import 'package:movies/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class EpisodeDetailBloc {
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<EpisodeDetailResponse> _subject =
      BehaviorSubject<EpisodeDetailResponse>();

  getEpisodeDetail(int id, int number, int episode) async {
    EpisodeDetailResponse response =
        await _repository.getEpisodeDetail(id, number, episode);
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

  BehaviorSubject<EpisodeDetailResponse> get subject => _subject;
}

final episodeDetailBloc = EpisodeDetailBloc();
