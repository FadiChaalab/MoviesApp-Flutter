import 'package:flutter/widgets.dart';
import 'package:movies/db/tv_favorites_helper.dart';
import 'package:movies/model/tv.dart';

class TvFavoritesModel extends ChangeNotifier {
  TvFavoriteHelper db;
  List<TvShows> favorites = List<TvShows>();

  TvFavoritesModel() {
    db = TvFavoriteHelper();
    fetchFavorites();
  }

  add(TvShows tv) async {
    if (!alreadyExists(tv)) {
      await db.add(tv);
      fetchFavorites();
    }
  }

  remove(TvShows tv) async {
    await db.remove(tv);
    fetchFavorites();
  }

  alreadyExists(TvShows tv) {
    for (TvShows item in favorites) {
      if (tv.id == item.id) return true;
    }
    return false;
  }

  fetchFavorites() async {
    favorites = await db.getTvFavorites();
    notifyListeners();
  }
}
