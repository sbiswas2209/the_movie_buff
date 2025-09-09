import 'package:json_annotation/json_annotation.dart';

part 'movie_cast.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieCastResponse {
  final int id;
  final List<CastMember> cast;

  MovieCastResponse({required this.id, required this.cast});

  factory MovieCastResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieCastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCastResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CastMember {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double? popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String? creditId;
  final int? order;

  // Optional: for fields that occasionally appear or are misspelled in rare objects
  final String? original_; // Handles "original_" typo

  CastMember({
    required this.adult,
    this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.original_,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) =>
      _$CastMemberFromJson(json);

  Map<String, dynamic> toJson() => _$CastMemberToJson(this);
}
