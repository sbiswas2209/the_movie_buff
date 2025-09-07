import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_buff/data/remote/genre_item.dart';

part 'genre_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GenreListResponse {
  final List<GenreItem> genres;

  const GenreListResponse({required this.genres});

  factory GenreListResponse.fromJson(Map<String, dynamic> json) =>
      _$GenreListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenreListResponseToJson(this);
}
