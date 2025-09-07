import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:the_movie_buff/data/remote/now_playing_response.dart';
import 'package:the_movie_buff/data/remote/popular_movies_response.dart';

part 'movies_client.g.dart';

@RestApi()
abstract class MoviesClient {
  factory MoviesClient(Dio dio, {String? baseUrl}) = _MoviesClient;

  @GET('/movie/popular')
  Future<PopularMoviesResponse> getPopularMovies({
    @Query('page') required int page,
    @Query('language') String language = 'en-US',
    @Query('region') String region = 'US',
  });

  @GET('/movie/now_playing')
  Future<NowPlayingResponse> getNowPlayingMovies({
    @Query('page') required int page,
    @Query('language') String language = 'en-US',
    @Query('region') String? region,
  });
}
