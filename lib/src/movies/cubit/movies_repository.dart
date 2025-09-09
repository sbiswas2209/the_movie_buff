import 'package:dio/dio.dart';
import 'package:the_movie_buff/core/services/database_service.dart';
import 'package:the_movie_buff/core/utils/dio_client.dart';
import 'package:the_movie_buff/data/remote/movie.dart';
import 'package:the_movie_buff/data/remote/movie_cast.dart';
import 'package:the_movie_buff/data/remote/movie_detail.dart';
import 'package:the_movie_buff/data/remote/movie_watch_providers.dart';
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

  Future<List<Movie>> getCachedPopularMovies();

  Future<List<Movie>> getCachedNowPlayingMovies();

  Future<int> addPopularMovieToCache(Movie movie);

  Future<int> addNowPlayingMovieToCache(Movie movie);

  Future<int> deletePopularMoviesCache();

  Future<int> deleteNowPlayingMoviesCache();

  Future<(bool, MovieDetail?)> getMovieDetails(
    int movieId, {
    String language = 'en-US',
  });

  Future<List<Movie>> getSearchMovies(
    String query,
    int page, {
    String language = 'en-US',
    bool includeAdult = false,
  });

  Future<MovieWatchProviders> getWatchProviders(int movieId);

  Future<MovieCastResponse> getCast(int movieId);

  Future<List<Movie>> getWatchlist();

  Future<int> addToWatchlist(Movie movie);

  Future<int> removeFromWatchlist(int movieId);
}

class MoviesRepositoryImpl implements MoviesRepository {
  late final MoviesClient moviesClient;
  static const popularMoviesTable = 'popular_movies';
  static const nowPlayingMoviesTable = 'now_playing_movies';
  static const watchlistTable = 'watchlist';

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
      page,
      language,
      region,
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
      page,
      language,
      region,
    );

    return response;
  }

  @override
  Future<List<Movie>> getCachedPopularMovies() async {
    return await DatabaseService.instance.selectAll<Movie>(
      popularMoviesTable,
      (json) => Movie.fromJson(json),
      orderBy: 'popularity DESC, id DESC',
      limit: 20,
    );
  }

  @override
  Future<List<Movie>> getCachedNowPlayingMovies() async {
    return await DatabaseService.instance.selectAll<Movie>(
      nowPlayingMoviesTable,
      (json) => Movie.fromJson(json),
      orderBy: 'popularity DESC, id DESC',
      limit: 20,
    );
  }

  @override
  Future<int> addPopularMovieToCache(Movie movie) async {
    return await DatabaseService.instance.insert<Movie>(
      popularMoviesTable,
      movie,
      (e) => e.toJson(),
    );
  }

  @override
  Future<int> addNowPlayingMovieToCache(Movie movie) async {
    return await DatabaseService.instance.insert<Movie>(
      nowPlayingMoviesTable,
      movie,
      (e) => e.toJson(),
    );
  }

  @override
  Future<int> deletePopularMoviesCache() async {
    return await DatabaseService.instance.deleteAll(popularMoviesTable);
  }

  @override
  Future<int> deleteNowPlayingMoviesCache() async {
    return await DatabaseService.instance.deleteAll(nowPlayingMoviesTable);
  }

  @override
  Future<(bool, MovieDetail?)> getMovieDetails(
    int movieId, {
    String language = 'en-US',
  }) async {
    try {
      return (true, await moviesClient.getMovieDetails(movieId, language));
    } on DioException catch (e) {
      Movie? cachedMovie = await getMovieFromCachedDB(
        movieId,
        popularMoviesTable,
      );
      cachedMovie ??= await getMovieFromCachedDB(
        movieId,
        nowPlayingMoviesTable,
      );

      if (cachedMovie != null) {
        return (
          false,
          MovieDetail(
            adult: cachedMovie.adult,
            backdropPath: cachedMovie.backdropPath,
            belongsToCollection: null,
            budget: 0,
            genres: [],
            homepage: '',
            id: cachedMovie.id,
            imdbId: '',
            originCountry: [],
            overview: cachedMovie.overview,
            popularity: cachedMovie.popularity,
            posterPath: cachedMovie.posterPath,
            productionCompanies: [],
            productionCountries: [],
            releaseDate: cachedMovie.releaseDate,
            revenue: 0,
            runtime: 0,
            spokenLanguages: [],
            status: 'Unknown',
            tagline: '',
            title: cachedMovie.title,
            video: false,
            voteAverage: cachedMovie.voteAverage,
            voteCount: cachedMovie.voteCount,
          ),
        );
      } else {
        return (false, null);
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<Movie?> getMovieFromCachedDB(int movieId, String tableName) async {
    return (await DatabaseService.instance.selectWhere(tableName, 'id = ?', [
      movieId,
    ], (json) => Movie.fromJson(json))).firstOrNull;
  }

  @override
  Future<List<Movie>> getSearchMovies(
    String query,
    int page, {
    String language = 'en-US',
    bool includeAdult = false,
  }) async {
    try {
      final response = await moviesClient.getSearchMovies(
        query,
        page,
        language,
        includeAdult,
      );
      return response.results;
    } on DioException catch (_) {
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieWatchProviders> getWatchProviders(int movieId) async {
    try {
      return await moviesClient.getMovieWatchProviders(movieId);
    } on DioException catch (_) {
      return MovieWatchProviders(results: {}, id: movieId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieCastResponse> getCast(int movieId) async {
    try {
      return await moviesClient.getMovieCredits(movieId);
    } on DioException catch (_) {
      return MovieCastResponse(cast: [], id: movieId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Movie>> getWatchlist() async {
    return await DatabaseService.instance.selectAll<Movie>(
      watchlistTable,
      (json) => Movie.fromJson(json),
    );
  }

  @override
  Future<int> addToWatchlist(Movie movie) async {
    return await DatabaseService.instance.insert<Movie>(
      watchlistTable,
      movie,
      (e) => e.toJson(),
    );
  }

  @override
  Future<int> removeFromWatchlist(int movieId) async {
    return await DatabaseService.instance.delete(watchlistTable, 'id = ?', [
      movieId,
    ]);
  }
}
