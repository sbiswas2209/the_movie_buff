import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:the_movie_buff/core/services/config_service.dart';
import 'package:the_movie_buff/core/styles/themes.dart';
import 'package:the_movie_buff/core/styles/typography.dart';
import 'package:the_movie_buff/core/utils/extensions/text_style.dart';
import 'package:the_movie_buff/core/utils/find_nearest_size.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_cubit.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_state.dart';

class WatchedMoviesPage extends StatefulWidget {
  const WatchedMoviesPage({super.key});

  @override
  State<WatchedMoviesPage> createState() => _WatchedMoviesPageState();
}

class _WatchedMoviesPageState extends State<WatchedMoviesPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MoviesCubit>().loadWatchlist();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watched Movies')),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        buildWhen: (previous, current) =>
            previous.watchlist != current.watchlist,
        builder: (context, state) {
          // Loading condition: You may adjust this flag if you fetch from DB/remote
          final isLoading = state.watchlist == null;
          final watched = state.watchlist ?? [];

          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                state.errorMessage,
                style: kParagraph1.withColor(Colors.red),
              ),
            );
          }

          if (isLoading) {
            return ListView.builder(
              itemCount: 8,
              itemBuilder: (_, __) => const ShimmerMovieTile(),
            );
          }

          if (watched.isEmpty) {
            return Center(
              child: Text(
                'No movies watched yet!',
                style: kParagraph1.withColor(kOnPrimaryColor),
              ),
            );
          }

          return ListView.builder(
            itemCount: watched.length,
            itemBuilder: (context, index) {
              final movie = watched[index];
              return ListTile(
                leading: movie.posterPath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CachedNetworkImage(
                          imageUrl:
                              '${ConfigService.instance.imageBaseUrl}${findNearestPosterSize(50.w)}${movie.posterPath}',
                          width: 50.w,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.movie),
                title: Text(movie.title, style: kHeading2),
                subtitle: Text(
                  'Released ${Jiffy.parse(movie.releaseDate).fromNow()}',
                  style: kParagraph2,
                ),
                onTap: () {
                  context.push('/details/${movie.id}');
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ShimmerMovieTile extends StatelessWidget {
  const ShimmerMovieTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListTile(
        leading: Container(width: 50, height: 75, color: Colors.white),
        title: Container(
          height: 16,
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 4),
        ),
        subtitle: Container(
          height: 14,
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 2),
        ),
      ),
    );
  }
}
