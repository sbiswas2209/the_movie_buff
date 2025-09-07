// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreItem _$GenreItemFromJson(Map<String, dynamic> json) =>
    GenreItem(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$GenreItemToJson(GenreItem instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
