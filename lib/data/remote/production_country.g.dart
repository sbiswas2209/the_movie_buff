// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionCountry _$ProductionCountryFromJson(Map<String, dynamic> json) =>
    ProductionCountry(
      name: json['name'] as String,
      iso_3166_1: json['iso_3166_1'] as String?,
    );

Map<String, dynamic> _$ProductionCountryToJson(ProductionCountry instance) =>
    <String, dynamic>{'iso_3166_1': instance.iso_3166_1, 'name': instance.name};
