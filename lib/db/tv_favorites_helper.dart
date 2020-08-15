import 'package:movies/model/tv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class TvFavoriteHelper {
  static Database _database;
  String table = "tvs";

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "tvs.db";
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $table ("
          "id INTEGER,"
          "name TEXT,"
          "vote_count DOUBLE,"
          "first_air_date TEXT,"
          "backdrop_path TEXT,"
          "overview TEXT,"
          "vote_average DOUBLE,"
          "popularity DOUBLE,"
          "poster_path TEXT"
          ")",
        );
      },
    );
  }

  remove(TvShows tv) async {
    final db = await database;
    await db.rawDelete("delete from $table where id = ${tv.id}");
  }

  add(TvShows tv) async {
    final db = await database;
    var res = await db.insert(table, toMap(tv));
    return res;
  }

  getTvFavorites() async {
    final db = await database;
    var res = await db.query(table);
    List<TvShows> list = res.isNotEmpty
        ? res.map((c) => TvShows.fromJson(c)).toList()
        : List<TvShows>();
    return list;
  }

  toMap(TvShows tv) {
    return {
      'id': tv.id,
      'name': tv.title,
      'vote_count': tv.count,
      'first_air_date': tv.release,
      'backdrop_path': tv.backPoster,
      'overview': tv.overview,
      'vote_average': tv.rating,
      'popularity': tv.popularity,
      'poster_path': tv.poster,
    };
  }
}
