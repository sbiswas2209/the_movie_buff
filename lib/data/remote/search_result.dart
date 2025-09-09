import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_buff/data/remote/movie.dart';

part 'search_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SearchResult {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  const SearchResult({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
