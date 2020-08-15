import 'package:movies/model/tv_response.dart';
import 'package:movies/repository/tv_repository.dart';
import 'package:rxdart/rxdart.dart';

class PopularTvListBloc {
  final TvRepository _repository = TvRepository();
  final BehaviorSubject<TvShowsResponse> _subject =
      BehaviorSubject<TvShowsResponse>();

  getPopularTv() async {
    TvShowsResponse response = await _repository.getTvShows();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<TvShowsResponse> get subject => _subject;
}

final popularTvBloc = PopularTvListBloc();
