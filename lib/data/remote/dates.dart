import 'package:json_annotation/json_annotation.dart';

part 'dates.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Dates {
  final String maximum;
  final String minimum;

  Dates({required this.maximum, required this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);
}
