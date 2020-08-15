import 'package:flutter/widgets.dart';
import 'package:movies/model/movie.dart';
import 'movie_favorite_helper.dart';

class MovieFavoritesModel extends ChangeNotifier {
  MovieFavoriteHelper db;
  List<Movie> favorites = List<Movie>();

  MovieFavoritesModel() {
    db = MovieFavoriteHelper();
    fetchFavorites();
  }

  add(Movie movie) async {
    if (!alreadyExists(movie)) {
      await db.add(movie);
      fetchFavorites();
    }
  }

  remove(Movie movie) async {
    await db.remove(movie);
    fetchFavorites();
  }

  alreadyExists(Movie movie) {
    for (Movie item in favorites) {
      if (movie.id == item.id) return true;
    }
    return false;
  }

  fetchFavorites() async {
    favorites = await db.getMovieFavorites();
    notifyListeners();
  }
}
