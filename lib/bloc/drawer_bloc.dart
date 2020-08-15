import 'package:bloc/bloc.dart';
import 'package:movies/screens/about.dart';
import 'package:movies/screens/favorites.dart';
import 'package:movies/screens/movie_screen.dart';
import 'package:movies/screens/settings.dart';
import 'package:movies/screens/tvshows.dart';

enum DrawerEvents {
  MoviesEvent,
  TvShowsEvent,
  FavoritesEvent,
  AboutEvent,
  SettingsEvent
}

abstract class DrawerStates {}

class DrawerBloc extends Bloc<DrawerEvents, DrawerStates> {
  @override
  DrawerStates get initialState => MovieScreen();

  @override
  Stream<DrawerStates> mapEventToState(DrawerEvents event) async* {
    switch (event) {
      case DrawerEvents.MoviesEvent:
        yield MovieScreen();
        break;
      case DrawerEvents.TvShowsEvent:
        yield TvShowsScreen();
        break;
      case DrawerEvents.FavoritesEvent:
        yield Favorites();
        break;
      case DrawerEvents.AboutEvent:
        yield About();
        break;
      case DrawerEvents.SettingsEvent:
        yield Settings();
        break;
    }
  }
}
