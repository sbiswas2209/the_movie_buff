import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_buff/data/remote/movie.dart';

part 'popular_movies_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PopularMoviesResponse {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  const PopularMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularMoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMoviesResponseToJson(this);
}
