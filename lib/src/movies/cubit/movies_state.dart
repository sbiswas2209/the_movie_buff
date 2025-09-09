import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_movie_buff/data/remote/movie.dart';

part 'movies_state.freezed.dart';

@freezed
abstract class MoviesState with _$MoviesState {
  const factory MoviesState({
    List<Movie>? popularMovies,
    List<Movie>? nowPlayingMovies,
    @Default(1) int popularMoviesPage,
    @Default(1) int nowPlayingMoviesPage,
    @Default(false) bool hasReachedPopularMoviesMax,
    @Default(false) bool hasReachedNowPlayingMoviesMax,
    @Default(false) bool isFetchingPopular,
    @Default(false) bool isFetchingNowPlaying,
    @Default(null) List<Movie>? searchResults,
    @Default(false) bool isSearching,
    @Default('') String errorMessage,
    @Default(null) List<Movie>? watchlist,
  }) = _MoviesState;
}
