// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_watch_providers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieWatchProviders _$MovieWatchProvidersFromJson(Map<String, dynamic> json) =>
    MovieWatchProviders(
      id: (json['id'] as num).toInt(),
      results: (json['results'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          CountryWatchProvider.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );

Map<String, dynamic> _$MovieWatchProvidersToJson(
  MovieWatchProviders instance,
) => <String, dynamic>{'id': instance.id, 'results': instance.results};

CountryWatchProvider _$CountryWatchProviderFromJson(
  Map<String, dynamic> json,
) => CountryWatchProvider(
  link: json['link'] as String,
  rent: (json['rent'] as List<dynamic>?)
      ?.map((e) => ProviderInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
  buy: (json['buy'] as List<dynamic>?)
      ?.map((e) => ProviderInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
  flatrate: (json['flatrate'] as List<dynamic>?)
      ?.map((e) => ProviderInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CountryWatchProviderToJson(
  CountryWatchProvider instance,
) => <String, dynamic>{
  'link': instance.link,
  'rent': instance.rent,
  'buy': instance.buy,
  'flatrate': instance.flatrate,
};

ProviderInfo _$ProviderInfoFromJson(Map<String, dynamic> json) => ProviderInfo(
  logoPath: json['logo_path'] as String,
  providerId: (json['provider_id'] as num).toInt(),
  providerName: json['provider_name'] as String,
  displayPriority: (json['display_priority'] as num).toInt(),
);

Map<String, dynamic> _$ProviderInfoToJson(ProviderInfo instance) =>
    <String, dynamic>{
      'logo_path': instance.logoPath,
      'provider_id': instance.providerId,
      'provider_name': instance.providerName,
      'display_priority': instance.displayPriority,
    };
