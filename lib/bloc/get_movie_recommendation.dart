import 'package:flutter/material.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class RecommendationsMoviesBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getRecommendationsMovies(int id) async {
    MovieResponse response = await _repository.getRecommendationMovies(id);
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

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final recommendationsMoviesBloc = RecommendationsMoviesBloc();
