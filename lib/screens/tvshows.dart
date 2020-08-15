import 'package:flutter/material.dart';
import 'package:movies/bloc/drawer_bloc.dart';
import 'package:movies/widgets/genres_tv.dart';
import 'package:movies/widgets/now_playing_tv.dart';
import 'package:movies/widgets/now_popular_tv.dart';
import 'package:movies/widgets/popular_tv.dart';

class TvShowsScreen extends StatelessWidget with DrawerStates {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        NowPlayingTv(),
        GenresTvScreen(),
        BestTvShows(),
        PopularTvShows(),
      ],
    );
  }
}
