import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:the_movie_buff/core/services/config_service.dart';
import 'package:the_movie_buff/core/styles/themes.dart';
import 'package:the_movie_buff/core/styles/typography.dart';
import 'package:the_movie_buff/core/utils/extensions/text_style.dart';
import 'package:the_movie_buff/core/utils/find_nearest_size.dart';
import 'package:the_movie_buff/data/remote/movie_cast.dart';
import 'package:the_movie_buff/data/remote/movie_detail.dart';
import 'package:the_movie_buff/data/remote/movie_watch_providers.dart';
import 'package:the_movie_buff/gen/assets.gen.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_cubit.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_state.dart';
import 'package:the_movie_buff/src/movies/widgets/genre_chip.dart';

class DetailsPage extends StatefulWidget {
  final int? id;

  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final Future<(bool, MovieDetail?)> movieDetailsFuture;
  late final Future<CountryWatchProvider?> watchProvidersFuture;

  late final Future<List<CastMember>> castMembersFuture;

  @override
  void initState() {
    movieDetailsFuture = context.read<MoviesCubit>().fetchMovieDetails(
      widget.id!,
    );
    watchProvidersFuture = context.read<MoviesCubit>().fetchWatchProviders(
      widget.id,
    );
    castMembersFuture = context.read<MoviesCubit>().fetchCast(widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movieDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(body: _buildShimmerPage());
        }

        final (bool success, MovieDetail? movieDetail) =
            snapshot.data ?? (false, null);

        return Scaffold(
          appBar: AppBar(
            title: LayoutBuilder(
              builder: (context, constraints) {
                final textPainter = TextPainter(
                  text: TextSpan(
                    text: movieDetail?.title ?? 'Movie Details',
                    style: kHeading2.bold,
                  ),
                  maxLines: 1,
                  textDirection: TextDirection.ltr,
                  textScaler: MediaQuery.of(context).textScaler,
                )..layout(maxWidth: constraints.maxWidth);

                final willOverflow = textPainter.didExceedMaxLines;
                if (!willOverflow) {
                  return Text(
                    movieDetail?.title ?? 'Movie Details',
                    style: kHeading2.bold,
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return LimitedBox(
                  maxWidth: constraints.maxWidth,
                  maxHeight: kToolbarHeight,
                  child: Marquee(
                    text: movieDetail?.title ?? 'Movie Details',
                    blankSpace: 50.w,
                    velocity: 30,
                  ),
                );
              },
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(
                      text:
                          "Hey check this movie out: https://tmb.sagnik.dev/details/${widget.id}",
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Movie link copied to clipboard!',
                        style: kParagraph1.withColor(kOnPrimaryColor),
                      ),
                      backgroundColor: kPrimaryColor,
                    ),
                  );
                },
                icon: Icon(Icons.share, color: kOnSecondaryColor),
                iconSize: 16.sp,
              ),
            ],
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: _buildBannerImage(movieDetail),
                  ),
                  SizedBox(height: 16.h),
                  _buildOverviewSection(movieDetail),
                  SizedBox(height: 24.h),
                  _buildGenresSection(movieDetail),
                  SizedBox(height: 24.h),
                  _buildRatingAndWatchedLayout(
                    movieDetail!.voteAverage.toStringAsFixed(1),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: _buildProductionCompaniesSection(movieDetail),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: _buildWatchProvidersSection(),
                  ),
                  SizedBox(height: 24.h),
                  _buildCreditsSection(),
                  SizedBox(height: 40.h),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBannerImage(MovieDetail? movieDetail) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: movieDetail?.backdropPath != null
              ? NetworkImage(
                  'https://image.tmdb.org/t/p/w500${movieDetail!.backdropPath}',
                )
              : const AssetImage('assets/placeholder.png') as ImageProvider,
        ),
      ),
    );
  }

  Widget _buildOverviewSection(MovieDetail? movieDetail) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Overview", style: kHeading1.bold),
          SizedBox(height: 5.h),
          Text(
            movieDetail?.overview.isNotEmpty == true
                ? movieDetail!.overview
                : 'No overview available.',
            style: kParagraph1,
          ),
        ],
      ),
    );
  }

  Widget _buildGenresSection(MovieDetail? movieDetail) {
    if (movieDetail == null || movieDetail.genres.isEmpty) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: movieDetail.genres.map((genre) {
          return GenreChip(genre: genre.name, variant: GenreChipVariant.large);
        }).toList(),
      ),
    );
  }

  Widget _buildRatingAndWatchedLayout(String rating) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.star_rounded, size: 36.sp, color: kPrimaryColor),
                SizedBox(width: 5.w),
                RichText(
                  text: TextSpan(
                    text: rating,
                    style: kParagraph1
                        .withColor(kPrimaryColor)
                        .withFontSize(24.sp)
                        .bold,
                    children: [
                      TextSpan(
                        text: ' / 10',
                        style: kParagraph1
                            .withColor(kOnPrimaryColor)
                            .withFontSize(24.sp)
                            .semiBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Watched", style: kHeading2),
                BlocBuilder<MoviesCubit, MoviesState>(
                  buildWhen: (previous, current) =>
                      previous.watchlist != current.watchlist,
                  builder: (context, state) {
                    final watched =
                        state.watchlist?.any(
                          (movie) => movie.id == widget.id,
                        ) ??
                        false;
                    return Switch(
                      value: watched,
                      onChanged: (value) {
                        if (value) {
                          context.read<MoviesCubit>().addMovieToWatchlist(
                            widget.id!,
                          );
                        } else {
                          context.read<MoviesCubit>().removeFromWatchList(
                            widget.id!,
                          );
                        }
                      },
                      activeThumbColor: kOnPrimaryColor,
                      activeTrackColor: kPrimaryColor,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductionCompaniesSection(MovieDetail? movieDetail) {
    if (movieDetail == null || movieDetail.productionCompanies.isEmpty) {
      return SizedBox.shrink();
    }

    return Text(
      "Produced By ${movieDetail.productionCompanies.map((e) => e.name).join(", ")}",
      style: kParagraph2.withColor(kOnPrimaryColor),
    );
  }

  Widget _buildWatchProvidersSection() {
    return FutureBuilder(
      future: watchProvidersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemCount: 5,
            itemBuilder: (context, index) => Shimmer(
              child: Container(
                width: 60.w,
                height: 60.h,
                color: Colors.grey[700],
              ),
            ),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text(
              'Failed to load watch providers.',
              style: kParagraph1.withColor(Colors.redAccent),
            ),
          );
        }

        final allProviders = [
          ...(snapshot.data!.buy ?? []),
          ...(snapshot.data!.rent ?? []),
          ...(snapshot.data!.flatrate ?? []),
        ];

        final seenNames = <String>{};
        final providers =
            allProviders
                .where((provider) => seenNames.add(provider.providerName))
                .toList()
              ..sort((a, b) => a.displayPriority - b.displayPriority);

        if (providers.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Watch on ", style: kHeading2),
            SizedBox(height: 12.h),
            LimitedBox(
              maxHeight: 60.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(right: 16.w),
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemCount: providers.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final provider = providers[index];
                  return LimitedBox(
                    maxWidth: 60.w,
                    maxHeight: 60.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 60.h,
                            width: 60.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  "${ConfigService.instance.imageBaseUrl}${findNearestPosterSize(60.w)}${provider.logoPath}",
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          provider.providerName,
                          style: kParagraph2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCreditsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full Credits',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          FutureBuilder(
            future: castMembersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Shimmer(
                  child: Column(
                    children: List.generate(
                      3,
                      (_) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.h,
                              color: Colors.grey[700],
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 12.h,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(height: 6.h),
                                  Container(
                                    width: 150.w,
                                    height: 12.h,
                                    color: Colors.grey[700],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Could not load cast',
                    style: kParagraph2.withColor(Colors.red),
                  ),
                );
              }
              final castMembers = snapshot.data ?? [];

              if (castMembers.isEmpty) {
                return Text(
                  'No cast information available.',
                  style: kParagraph2.withColor(kOnPrimaryColor),
                );
              }

              return Column(
                children: castMembers.map((cast) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: cast.profilePath != null
                                  ? CachedNetworkImageProvider(
                                      "${ConfigService.instance.imageBaseUrl}${findNearestPosterSize(40.w)}${cast.profilePath}",
                                    )
                                  : Assets.images.posterPlaceholder.provider(),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cast.name,
                                style: kParagraph1.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                cast.character ?? "",
                                style: kParagraph2.withColor(kOnPrimaryColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerPage() {
    return Shimmer(
      duration: Duration(seconds: 2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Image Placeholder
            Container(
              width: double.infinity,
              height: 300.h,
              color: Colors.grey[300],
            ),
            SizedBox(height: 16.h),

            // Overview Placeholder
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120.w,
                    height: 20.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    height: 60.h,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Genres Placeholder
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: List.generate(3, (_) {
                  return Container(
                    margin: EdgeInsets.only(right: 8.w),
                    width: 80.w,
                    height: 24.h,
                    color: Colors.grey[300],
                  );
                }),
              ),
            ),
            SizedBox(height: 24.h),

            // Watched Toggle Placeholder
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: 100.w,
                height: 24.h,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 24.h),

            // Rating Placeholder
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: 80.w,
                height: 24.h,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 24.h),

            // Production Companies Placeholder
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                height: 60.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) => Container(
                    width: 60.w,
                    height: 60.h,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Watch Providers Placeholder
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                height: 60.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) => Container(
                    width: 60.w,
                    height: 60.h,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Credits Placeholder
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 160.w,
                    height: 20.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: 140.w,
                    height: 24.h,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
