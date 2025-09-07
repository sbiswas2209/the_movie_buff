import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_movie_buff/data/remote/movie.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_cubit.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);
typedef ToMap<T> = Map<String, dynamic> Function(T object);

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  static DatabaseService get instance => _instance;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  static const int _databaseVersion = 1;
  late final String _databasePath;
  late final Database _database;

  Future<void> init([String? databasePath]) async {
    _databasePath = databasePath ?? await getDatabasesPath();
    final path = join(_databasePath, 'app_database.db');

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute(Movie.createTable(MoviesCubit.popularMoviesTable));
        await db.execute(Movie.createTable(MoviesCubit.nowPlayingMoviesTable));
      },
    );
  }

  Future<int> insert<T>(String tableName, T object, ToMap<T> toMap) async {
    final map = toMap(object);
    return _database.insert(
      tableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<T>> selectAll<T>(
    String tableName,
    FromJson<T> fromJson, {
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      tableName,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
    return maps.map((json) => fromJson(json)).toList();
  }

  Future<List<T>> selectWhere<T>(
    String tableName,
    String where,
    List<dynamic> whereArgs,
    FromJson<T> fromJson, {
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
    return maps.map((json) => fromJson(json)).toList();
  }

  Future<int> delete(
    String tableName,
    String where,
    List<dynamic> whereArgs,
  ) async {
    return _database.delete(tableName, where: where, whereArgs: whereArgs);
  }

  Future<int> deleteAll(String tableName) async {
    return _database.delete(tableName);
  }

  Future<void> close() async {
    await _database.close();
  }
}
