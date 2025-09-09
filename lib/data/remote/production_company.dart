import 'package:json_annotation/json_annotation.dart';

part 'production_company.g.dart';

@JsonSerializable()
class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String? originCountry;

  const ProductionCompany({
    required this.id,
    required this.name,
    this.originCountry,
    this.logoPath,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}
