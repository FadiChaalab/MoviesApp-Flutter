import 'package:flutter/material.dart';
import 'package:movies/model/tv_response.dart';
import 'package:movies/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class SimilarTvBloc {
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<TvShowsResponse> _subject =
      BehaviorSubject<TvShowsResponse>();

  getSimilarTv(int id) async {
    TvShowsResponse response = await _repository.getSimilarTvs(id);
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

  BehaviorSubject<TvShowsResponse> get subject => _subject;
}

final similarTvBloc = SimilarTvBloc();
