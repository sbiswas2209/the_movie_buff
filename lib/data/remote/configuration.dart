import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_buff/data/remote/images.dart';

part 'configuration.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Configuration {
  final List<String> changeKeys;
  final Images images;

  Configuration({required this.changeKeys, required this.images});

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);
}
