import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_buff/data/remote/dates.dart';
import 'package:the_movie_buff/data/remote/movie.dart';

part 'now_playing_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NowPlayingResponse {
  final Dates dates;
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  const NowPlayingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory NowPlayingResponse.fromJson(Map<String, dynamic> json) =>
      _$NowPlayingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NowPlayingResponseToJson(this);
}
