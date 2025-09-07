// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  adult: Movie._dynamicToBool(json['adult']),
  backdropPath: json['backdrop_path'] as String?,
  genreIds: (json['genre_ids'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  id: (json['id'] as num).toInt(),
  originalLanguage: json['original_language'] as String,
  originalTitle: json['original_title'] as String,
  overview: json['overview'] as String,
  popularity: (json['popularity'] as num).toDouble(),
  posterPath: json['poster_path'] as String,
  releaseDate: json['release_date'] as String,
  title: json['title'] as String,
  video: Movie._dynamicToBool(json['video']),
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
);

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'adult': Movie._boolToInt(instance.adult),
  'backdrop_path': instance.backdropPath,
  'genre_ids': instance.genreIds,
  'id': instance.id,
  'original_language': instance.originalLanguage,
  'original_title': instance.originalTitle,
  'overview': instance.overview,
  'popularity': instance.popularity,
  'poster_path': instance.posterPath,
  'release_date': instance.releaseDate,
  'title': instance.title,
  'video': Movie._boolToInt(instance.video),
  'vote_average': instance.voteAverage,
  'vote_count': instance.voteCount,
};
