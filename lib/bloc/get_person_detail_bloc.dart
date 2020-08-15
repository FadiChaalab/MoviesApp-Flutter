import 'package:flutter/material.dart';
import 'package:movies/model/detailed_person_response.dart';
import 'package:movies/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonDetailBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersonDetailResponse> _subject =
      BehaviorSubject<PersonDetailResponse>();

  getPersonDetail(int id) async {
    PersonDetailResponse response = await _repository.getPersonDetail(id);
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

  BehaviorSubject<PersonDetailResponse> get subject => _subject;
}

final personDetailBloc = PersonDetailBloc();
