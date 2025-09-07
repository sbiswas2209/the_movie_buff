import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie_buff/core/services/config_service.dart';
import 'package:the_movie_buff/core/styles/typography.dart';
import 'package:the_movie_buff/core/utils/extensions/text_style.dart';
import 'package:the_movie_buff/data/remote/genre_item.dart';
import 'package:the_movie_buff/data/remote/movie.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_cubit.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_state.dart';
import 'package:the_movie_buff/src/movies/widgets/now_playing_card.dart';
import 'package:the_movie_buff/src/movies/widgets/popular_movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _popularMoviesPageController = PageController(
    keepPage: true,
  );

  // Main scroll controller for the entire ListView
  final ScrollController _mainScrollController = ScrollController();
  bool _hasFetchedPopularMovies = false;

  Future<void> _fetchPopularMovies() async {
    await context.read<MoviesCubit>().fetchPopularMovies();
  }

  Future<void> _fetchNowPlayingMovies() async {
    if (mounted) {
      await context.read<MoviesCubit>().fetchNowPlayingMovies();
    }
  }

  void _setupListeners() {
    _mainScrollController.addListener(() {
      if (mounted) {
        final scrollPosition = _mainScrollController.position.pixels;
        final maxScrollExtent = _mainScrollController.position.maxScrollExtent;

        if (scrollPosition >= (maxScrollExtent * 0.8)) {
          _fetchNowPlayingMovies();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_hasFetchedPopularMovies) {
        _hasFetchedPopularMovies = true;
        await _fetchPopularMovies();
        await _fetchNowPlayingMovies();
        _setupListeners();
      }
    });
  }

  @override
  void dispose() {
    _popularMoviesPageController.dispose();
    _mainScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Movie Buff"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        controller: _mainScrollController,
        shrinkWrap: true,
        children: [
          SizedBox(height: 12.h),
          BlocBuilder<MoviesCubit, MoviesState>(
            buildWhen: (previous, current) =>
                previous.popularMovies != current.popularMovies ||
                previous.hasReachedPopularMoviesMax !=
                    current.hasReachedPopularMoviesMax ||
                previous.isFetchingPopular != current.isFetchingPopular,
            builder: (context, state) {
              if (state.popularMovies == null) {
                return PopularMovieCard.shimmer();
              } else if (state.popularMovies!.isEmpty) {
                return Center(child: Text("No popular movies found"));
              } else {
                return _buildPopularMoviesCarousel(state.popularMovies!);
              }
            },
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            child: Text("Now Playing", style: kHeading2.bold),
          ),
          BlocBuilder<MoviesCubit, MoviesState>(
            buildWhen: (previous, current) =>
                previous.nowPlayingMovies != current.nowPlayingMovies ||
                previous.hasReachedNowPlayingMoviesMax !=
                    current.hasReachedNowPlayingMoviesMax ||
                previous.isFetchingNowPlaying != current.isFetchingNowPlaying,
            builder: (context, state) {
              if (state.nowPlayingMovies == null) {
                return NowPlayingCard.shimmer();
              } else if (state.nowPlayingMovies!.isEmpty) {
                return Center(child: Text("No movies playing currently"));
              } else {
                return _buildNowPlayingGrid(state.nowPlayingMovies!, state);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPopularMoviesCarousel(List<Movie> movies) {
    return LimitedBox(
      maxHeight: 1.sh / 2.5,
      child: PageView.builder(
        controller: _popularMoviesPageController,
        itemCount: movies.length,
        onPageChanged: (page) {
          // Trigger pagination when approaching the end
          if (page >= movies.length - 2 &&
              !context.read<MoviesCubit>().state.isFetchingPopular &&
              !context.read<MoviesCubit>().state.hasReachedPopularMoviesMax) {
            context.read<MoviesCubit>().fetchPopularMovies();
          }
        },
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: PopularMovieCard(
              title: movie.title,
              imagePath: movie.backdropPath,
              onPressed: () {},
              genres: movie.genreIds
                  .map<GenreItem>(
                    (e) => ConfigService.instance.genres.firstWhere(
                      (g) => g.id == e,
                      orElse: () => GenreItem(id: -1, name: ''),
                    ),
                  )
                  .where((e) => e.id != -1)
                  .map((e) => e.name)
                  .toList(),
              releaseDate: movie.releaseDate,
              voteAverage: movie.voteAverage,
              voteCount: movie.voteCount,
              adult: movie.adult,
            ),
          );
        },
      ),
    );
  }

  Widget _buildNowPlayingGrid(List<Movie> movies, MoviesState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        itemCount: movies.length + (state.isFetchingNowPlaying ? 2 : 0),
        itemBuilder: (context, index) {
          if (index >= movies.length) {
            return NowPlayingCard.shimmer();
          }

          final movie = movies[index];
          return NowPlayingCard(
            title: movie.title,
            voteAverage: movie.voteAverage,
            posterPath: movie.posterPath,
            adult: movie.adult,
          );
        },
      ),
    );
  }
}
