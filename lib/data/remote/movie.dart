import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie extends Equatable {
  @JsonKey(fromJson: _dynamicToBool, toJson: _boolToInt)
  final bool adult;

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final String title;

  @JsonKey(fromJson: _dynamicToBool, toJson: _boolToInt)
  final bool video;

  final double voteAverage;
  final int voteCount;

  const Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  static String createTable(String tableName) =>
      // TODO: Fix genre_ids storage
      '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY,
      adult INTEGER,
      backdrop_path TEXT,
      genre_ids TEXT,
      original_language TEXT,
      original_title TEXT,
      overview TEXT,
      popularity REAL,
      poster_path TEXT,
      release_date TEXT,
      title TEXT,
      video INTEGER,
      vote_average REAL,
      vote_count INTEGER
    )
  ''';

  static bool _dynamicToBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) return value == '1';
    return false;
  }

  static int _boolToInt(bool value) => value ? 1 : 0;

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genreIds,
    id,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  ];
}
