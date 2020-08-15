import 'package:flutter/material.dart';
import 'package:movies/model/season_detail_response.dart';
import 'package:movies/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class SeasonDetailBloc {
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<SeasonDetailResponse> _subject =
      BehaviorSubject<SeasonDetailResponse>();

  getSeasonDetail(int id, int number) async {
    SeasonDetailResponse response =
        await _repository.getSeasonDetail(id, number);
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

  BehaviorSubject<SeasonDetailResponse> get subject => _subject;
}

final seasonDetailBloc = SeasonDetailBloc();
