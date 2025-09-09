// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_cast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCastResponse _$MovieCastResponseFromJson(Map<String, dynamic> json) =>
    MovieCastResponse(
      id: (json['id'] as num).toInt(),
      cast: (json['cast'] as List<dynamic>)
          .map((e) => CastMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieCastResponseToJson(MovieCastResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast.map((e) => e.toJson()).toList(),
    };

CastMember _$CastMemberFromJson(Map<String, dynamic> json) => CastMember(
  adult: json['adult'] as bool,
  gender: (json['gender'] as num?)?.toInt(),
  id: (json['id'] as num).toInt(),
  knownForDepartment: json['known_for_department'] as String,
  name: json['name'] as String,
  originalName: json['original_name'] as String,
  popularity: (json['popularity'] as num?)?.toDouble(),
  profilePath: json['profile_path'] as String?,
  castId: (json['cast_id'] as num?)?.toInt(),
  character: json['character'] as String?,
  creditId: json['credit_id'] as String?,
  order: (json['order'] as num?)?.toInt(),
  original_: json['original_'] as String?,
);

Map<String, dynamic> _$CastMemberToJson(CastMember instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'cast_id': instance.castId,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
      'original_': instance.original_,
    };
