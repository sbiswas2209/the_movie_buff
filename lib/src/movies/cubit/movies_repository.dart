import 'package:the_movie_buff/core/utils/dio_client.dart';
import 'package:the_movie_buff/data/remote/now_playing_response.dart';
import 'package:the_movie_buff/data/remote/popular_movies_response.dart';
import 'package:the_movie_buff/network/api/movies/movies_client.dart';

abstract class MoviesRepository {
  Future<PopularMoviesResponse> getPopularMovies(
    int page, {
    String language = 'en-US',
    String region = 'US',
  });

  Future<NowPlayingResponse> getNowPlayingMovies(
    int page, {
    String language = 'en-US',
    String? region,
  });
}

class MoviesRepositoryImpl implements MoviesRepository {
  late final MoviesClient moviesClient;

  MoviesRepositoryImpl() {
    moviesClient = MoviesClient(dioClient);
  }

  @override
  Future<PopularMoviesResponse> getPopularMovies(
    int page, {
    String language = 'en-US',
    String region = 'US',
  }) async {
    PopularMoviesResponse response = await moviesClient.getPopularMovies(
      page: page,
    );

    return response;
  }

  @override
  Future<NowPlayingResponse> getNowPlayingMovies(
    int page, {
    String language = 'en-US',
    String? region,
  }) async {
    NowPlayingResponse response = await moviesClient.getNowPlayingMovies(
      page: page,
      language: language,
      region: region,
    );

    return response;
  }
}
