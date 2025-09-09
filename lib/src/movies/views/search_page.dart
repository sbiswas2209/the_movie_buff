import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movie_buff/core/styles/themes.dart';
import 'package:the_movie_buff/core/styles/typography.dart';
import 'package:the_movie_buff/core/utils/extensions/text_style.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_cubit.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_state.dart';
import 'package:the_movie_buff/src/movies/widgets/search_result_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<MoviesCubit>().resetSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) {
        context.read<MoviesCubit>().resetSearch();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            style: kParagraph1.withColor(kOnPrimaryColor),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: kParagraph1.withColor(kOnSecondaryColor),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              prefixIcon: Hero(
                tag: 'search_icon',
                child: Icon(Icons.search, color: kOnSecondaryColor),
              ),
            ),
            onChanged: (value) {
              context.read<MoviesCubit>().searchMovies(value);
            },
          ),
        ),
        body: BlocBuilder<MoviesCubit, MoviesState>(
          buildWhen: (previous, current) =>
              previous.searchResults != current.searchResults ||
              previous.isSearching != current.isSearching,
          builder: (context, state) {
            if (state.isSearching) {
              return ListView.builder(
                itemCount: 8,
                itemBuilder: (_, __) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: SearchResultTile.shimmer(),
                ),
              );
            }
            if (state.searchResults == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24.h),
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Text(
                      'Start typing to search for movies',
                      style: kParagraph1.withColor(kOnPrimaryColor),
                    ),
                  ),
                ],
              );
            }

            if ((state.searchResults ?? []).isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24.h),
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Text(
                      'No results found',
                      style: kParagraph1.withColor(kOnPrimaryColor),
                    ),
                  ),
                ],
              );
            }
            final movies = state.searchResults ?? [];
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: SearchResultTile(
                    id: movie.id,
                    title: movie.title,
                    posterPath: movie.posterPath,
                    onPressed: (id) {
                      context.push('/details/$id');
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
