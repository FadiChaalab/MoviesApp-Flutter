import 'package:flutter/material.dart';
import 'package:movies/model/tv_detailed_responce.dart';
import 'package:movies/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class TvDetailBloc {
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<TvDetailResponse> _subject =
      BehaviorSubject<TvDetailResponse>();

  getTvDetail(int id) async {
    TvDetailResponse response = await _repository.getTvDetail(id);
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

  BehaviorSubject<TvDetailResponse> get subject => _subject;
}

final tvDetailBloc = TvDetailBloc();
