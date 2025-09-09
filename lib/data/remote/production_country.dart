import 'package:json_annotation/json_annotation.dart';

part 'production_country.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountry {
  final String? iso_3166_1;
  final String name;

  ProductionCountry({required this.name, this.iso_3166_1});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);
}
