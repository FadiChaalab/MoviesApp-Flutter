import 'package:movies/model/genre_response.dart';
import 'package:movies/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class GenresTvListBloc {
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  getGenresTv() async {
    GenreResponse response = await _repository.getTvGenres();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}

final genresTvBloc = GenresTvListBloc();
