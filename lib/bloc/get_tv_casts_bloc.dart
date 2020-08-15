import 'package:flutter/material.dart';
import 'package:movies/model/Credits_response.dart';
import 'package:movies/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class CastsTvBloc {
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<CreditResponse> _subject =
      BehaviorSubject<CreditResponse>();

  getCasts(int id) async {
    CreditResponse response = await _repository.getCasts(id);
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

  BehaviorSubject<CreditResponse> get subject => _subject;
}

final castsTvBloc = CastsTvBloc();
