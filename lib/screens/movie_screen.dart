import 'package:flutter/material.dart';
import 'package:movies/bloc/drawer_bloc.dart';
import 'package:movies/widgets/best_movies.dart';
import 'package:movies/widgets/genres.dart';
import 'package:movies/widgets/now_playing.dart';
import 'package:movies/widgets/persons.dart';
import 'package:movies/widgets/upcoming_movies.dart';

class MovieScreen extends StatelessWidget with DrawerStates {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        NowPlaying(),
        GenresScreen(),
        PersonsList(),
        BestMovies(),
        UpcomingMovies(),
      ],
    );
  }
}
