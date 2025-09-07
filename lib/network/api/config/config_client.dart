import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:the_movie_buff/data/remote/configuration.dart';
import 'package:the_movie_buff/data/remote/genre_list_response.dart';

part 'config_client.g.dart';

@RestApi()
abstract class ConfigClient {
  factory ConfigClient(Dio dio, {String? baseUrl}) = _ConfigClient;

  @GET("/configuration")
  Future<Configuration> getConfiguration();

  @GET("/genre/movie/list")
  Future<GenreListResponse> getGenreList({
    @Query('language') String language = 'en',
  });
}
