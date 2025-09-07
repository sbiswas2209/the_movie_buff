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
import 'package:the_movie_buff/src/movies/widgets/popular_movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _popularMoviesPageController = PageController(
    viewportFraction: 0.8,
  );
  bool _hasFetchedPopularMovies = false;

  Future<void> _fetchPopularMovies() async {
    await context.read<MoviesCubit>().fetchPopularMovies();
  }

  Future<void> _fetchNowPlayingMovies() async {
    if (mounted) {
      await context.read<MoviesCubit>().fetchNowPlayingMovies();
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_hasFetchedPopularMovies) {
        _hasFetchedPopularMovies = true;
        await _fetchPopularMovies();
        await _fetchNowPlayingMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Movie Buff"),
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text("Popular Movies Now", style: kHeading1.bold),
          ),
          SizedBox(height: 12.h),
          BlocBuilder<MoviesCubit, MoviesState>(
            buildWhen: (previous, current) =>
                previous.popularMovies != current.popularMovies ||
                previous.hasReachedPopularMoviesMax !=
                    current.hasReachedPopularMoviesMax ||
                previous.isFetchingPopular != current.isFetchingPopular,
            builder: (context, state) {
              if (state.popularMovies == null) {
                return Center(child: CircularProgressIndicator());
              } else if (state.popularMovies!.isEmpty) {
                return Center(child: Text("No popular movies found"));
              } else {
                return _buildPopularMoviesCarousel(state.popularMovies!);
              }
            },
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text("Now Playing", style: kHeading1.bold),
          ),
          BlocBuilder<MoviesCubit, MoviesState>(
            buildWhen: (previous, current) =>
                previous.nowPlayingMovies != current.nowPlayingMovies ||
                previous.hasReachedNowPlayingMoviesMax !=
                    current.hasReachedNowPlayingMoviesMax ||
                previous.isFetchingNowPlaying != current.isFetchingNowPlaying,
            builder: (context, state) {
              if (state.nowPlayingMovies == null) {
                return Center(child: CircularProgressIndicator());
              } else if (state.nowPlayingMovies!.isEmpty) {
                return Center(child: Text("No movies playing currently"));
              } else {
                return _buildNowPlayingGrid(state.nowPlayingMovies!);
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
          if (page >= movies.length - 1) {
            context.read<MoviesCubit>().fetchPopularMovies();
          }
        },
        itemBuilder: (context, index) {
          final movie = movies[index];
          return PopularMovieCard(
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
            rating: movie.voteAverage,
            ratings: movie.voteCount,
          );
        },
      ),
    );
  }

  Widget _buildNowPlayingGrid(List<Movie> movies) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Container(child: Text(movies[index].title));
      },
    );
  }
}
