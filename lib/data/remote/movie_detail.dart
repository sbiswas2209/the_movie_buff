import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_buff/data/remote/genre_item.dart';
import 'package:the_movie_buff/data/remote/production_company.dart';
import 'package:the_movie_buff/data/remote/production_country.dart';
import 'package:the_movie_buff/data/remote/spoken_language.dart';

part 'movie_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieDetail {
  final bool adult;
  final String? backdropPath;
  final Map<String, dynamic>? belongsToCollection;
  final int budget;
  final List<GenreItem> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  const MovieDetail({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);
}
