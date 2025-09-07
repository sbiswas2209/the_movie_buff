import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:the_movie_buff/core/services/database_service.dart';
import 'package:the_movie_buff/data/remote/movie.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_repository.dart';

import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepository moviesRepository;

  static const popularMoviesTable = 'popular_movies';
  static const nowPlayingMoviesTable = 'now_playing_movies';

  MoviesCubit(this.moviesRepository) : super(const MoviesState());

  Future<void> fetchPopularMovies() async {
    if (state.isFetchingPopular || state.hasReachedPopularMoviesMax) {
      return;
    }

    emit(state.copyWith(isFetchingPopular: true, errorMessage: ''));

    try {
      if (state.popularMoviesPage == 1) {
        final cachedMovies = await DatabaseService.instance.selectAll<Movie>(
          popularMoviesTable,
          (json) => Movie.fromJson(json),
          orderBy: 'popularity DESC, id DESC',
          limit: 20,
        );

        if (cachedMovies.isNotEmpty) {
          emit(
            state.copyWith(
              popularMovies: cachedMovies,
              isFetchingPopular: true,
            ),
          );
        }
      }

      final response = await moviesRepository.getPopularMovies(
        state.popularMoviesPage,
      );

      final existingIds = (state.popularMovies ?? []).map((e) => e.id).toSet();

      final newMovies = response.results
          .where((movie) => !existingIds.contains(movie.id))
          .toList();

      final updatedList = <Movie>[...(state.popularMovies ?? []), ...newMovies];

      final hasReachedMax = response.page >= response.totalPages;

      for (Movie movie in newMovies) {
        await DatabaseService.instance.insert<Movie>(
          popularMoviesTable,
          movie,
          (e) => e.toJson(),
        );
      }

      emit(
        state.copyWith(
          popularMovies: updatedList,
          popularMoviesPage: state.popularMoviesPage + 1,
          hasReachedPopularMoviesMax: hasReachedMax,
          isFetchingPopular: false,
          errorMessage: '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isFetchingPopular: false,
          errorMessage: 'Failed to fetch popular movies: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> fetchNowPlayingMovies() async {
    if (state.isFetchingNowPlaying || state.hasReachedNowPlayingMoviesMax) {
      return;
    }

    emit(state.copyWith(isFetchingNowPlaying: true, errorMessage: ''));

    try {
      if (state.nowPlayingMoviesPage == 1) {
        final cachedMovies = await DatabaseService.instance.selectAll<Movie>(
          nowPlayingMoviesTable,
          (json) => Movie.fromJson(json),
          orderBy: 'popularity DESC, id DESC',
          limit: 20,
        );

        if (cachedMovies.isNotEmpty) {
          emit(
            state.copyWith(
              nowPlayingMovies: cachedMovies,
              isFetchingNowPlaying: true,
            ),
          );
        }
      }

      final response = await moviesRepository.getNowPlayingMovies(
        state.nowPlayingMoviesPage,
      );

      final existingIds = (state.nowPlayingMovies ?? [])
          .map((e) => e.id)
          .toSet();

      final newMovies = response.results
          .where((movie) => !existingIds.contains(movie.id))
          .toList();

      final updatedList = <Movie>[
        ...(state.nowPlayingMovies ?? []),
        ...newMovies,
      ];

      final hasReachedMax = response.page >= response.totalPages;

      for (Movie movie in newMovies) {
        await DatabaseService.instance.insert<Movie>(
          nowPlayingMoviesTable,
          movie,
          (e) => e.toJson(),
        );
      }

      emit(
        state.copyWith(
          nowPlayingMovies: updatedList,
          nowPlayingMoviesPage: state.nowPlayingMoviesPage + 1,
          hasReachedNowPlayingMoviesMax: hasReachedMax,
          isFetchingNowPlaying: false,
          errorMessage: '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isFetchingNowPlaying: false,
          errorMessage: 'Failed to fetch now playing movies: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> refreshPopularMovies() async {
    await DatabaseService.instance.deleteAll(popularMoviesTable);

    emit(
      state.copyWith(
        popularMovies: null,
        popularMoviesPage: 1,
        hasReachedPopularMoviesMax: false,
        isFetchingPopular: false,
      ),
    );

    await fetchPopularMovies();
  }

  Future<void> refreshNowPlayingMovies() async {
    await DatabaseService.instance.deleteAll(nowPlayingMoviesTable);

    emit(
      state.copyWith(
        nowPlayingMovies: null,
        nowPlayingMoviesPage: 1,
        hasReachedNowPlayingMoviesMax: false,
        isFetchingNowPlaying: false,
      ),
    );

    await fetchNowPlayingMovies();
  }

  void resetState() {
    emit(const MoviesState());
  }

  void clearError() {
    emit(state.copyWith(errorMessage: ''));
  }
}
