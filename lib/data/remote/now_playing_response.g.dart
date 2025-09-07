// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now_playing_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NowPlayingResponse _$NowPlayingResponseFromJson(Map<String, dynamic> json) =>
    NowPlayingResponse(
      dates: Dates.fromJson(json['dates'] as Map<String, dynamic>),
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$NowPlayingResponseToJson(NowPlayingResponse instance) =>
    <String, dynamic>{
      'dates': instance.dates,
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
