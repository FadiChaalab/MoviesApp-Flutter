import 'package:movies/model/movie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class MovieFavoriteHelper {
  static Database _database;
  String table = "movies";

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "movies.db";
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $table ("
          "id INTEGER,"
          "title TEXT,"
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

  remove(Movie m) async {
    final db = await database;
    await db.rawDelete("delete from $table where id = ${m.id}");
  }

  add(Movie m) async {
    final db = await database;
    var res = await db.insert(table, toMap(m));
    return res;
  }

  getMovieFavorites() async {
    final db = await database;
    var res = await db.query(table);
    List<Movie> list = res.isNotEmpty
        ? res.map((c) => Movie.fromJson(c)).toList()
        : List<Movie>();
    return list;
  }

  toMap(Movie movie) {
    return {
      'id': movie.id,
      'title': movie.title,
      'backdrop_path': movie.backPoster,
      'overview': movie.overview,
      'vote_average': movie.rating,
      'popularity': movie.popularity,
      'poster_path': movie.poster,
    };
  }
}
