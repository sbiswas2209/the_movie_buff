import 'package:json_annotation/json_annotation.dart';

part 'spoken_language.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguage {
  final String? englishName;
  final String? iso_639_1;
  final String name;

  SpokenLanguage({required this.name, this.iso_639_1, this.englishName});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}
