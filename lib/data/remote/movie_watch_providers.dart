import 'package:json_annotation/json_annotation.dart';

part 'movie_watch_providers.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieWatchProviders {
  final int id;
  final Map<String, CountryWatchProvider> results;

  MovieWatchProviders({required this.id, required this.results});

  factory MovieWatchProviders.fromJson(Map<String, dynamic> json) =>
      _$MovieWatchProvidersFromJson(json);

  Map<String, dynamic> toJson() => _$MovieWatchProvidersToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CountryWatchProvider {
  final String link;
  final List<ProviderInfo>? rent;
  final List<ProviderInfo>? buy;
  final List<ProviderInfo>? flatrate;

  CountryWatchProvider({
    required this.link,
    this.rent,
    this.buy,
    this.flatrate,
  });

  factory CountryWatchProvider.fromJson(Map<String, dynamic> json) =>
      _$CountryWatchProviderFromJson(json);

  Map<String, dynamic> toJson() => _$CountryWatchProviderToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProviderInfo {
  final String logoPath;
  final int providerId;
  final String providerName;
  final int displayPriority;

  ProviderInfo({
    required this.logoPath,
    required this.providerId,
    required this.providerName,
    required this.displayPriority,
  });

  factory ProviderInfo.fromJson(Map<String, dynamic> json) =>
      _$ProviderInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderInfoToJson(this);
}
