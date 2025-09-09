import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:the_movie_buff/data/remote/movie_cast.dart';
import 'package:the_movie_buff/data/remote/movie_detail.dart';
import 'package:the_movie_buff/data/remote/movie_watch_providers.dart';
import 'package:the_movie_buff/data/remote/now_playing_response.dart';
import 'package:the_movie_buff/data/remote/popular_movies_response.dart';
import 'package:the_movie_buff/data/remote/search_result.dart';

part 'movies_client.g.dart';

@RestApi()
abstract class MoviesClient {
  factory MoviesClient(Dio dio, {String? baseUrl}) = _MoviesClient;

  @GET('/movie/popular')
  Future<PopularMoviesResponse> getPopularMovies(
    @Query('page') int page,
    @Query('language') String language,
    @Query('region') String region,
  );

  @GET('/movie/now_playing')
  Future<NowPlayingResponse> getNowPlayingMovies(
    @Query('page') int page,
    @Query('language') String language,
    @Query('region') String? region,
  );

  @GET('/movie/{id}')
  Future<MovieDetail> getMovieDetails(
    @Path('id') int movieId,
    @Query('language') String language,
  );

  @GET('/search/movie')
  Future<SearchResult> getSearchMovies(
    @Query('query') String query,
    @Query('page') int page,
    @Query('language') String language,
    @Query('include_adult') bool includeAdult,
  );

  @GET('/movie/{movie_id}/watch/providers')
  Future<MovieWatchProviders> getMovieWatchProviders(
    @Path('movie_id') int movieId,
  );

  @GET('/movie/{movie_id}/credits')
  Future<MovieCastResponse> getMovieCredits(@Path('movie_id') int movieId);
}
