import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:the_movie_buff/data/remote/movie_detail.dart';
import 'package:the_movie_buff/src/movies/cubit/movies_cubit.dart';

class DetailsPage extends StatefulWidget {
  final int? id;

  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final Future<(bool, MovieDetail?)> movieDetailsFuture;

  @override
  void initState() {
    movieDetailsFuture = context.read<MoviesCubit>().fetchMovieDetails(
      widget.id!,
    );
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
            title: Text(movieDetail?.title ?? 'Movie Details'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBannerImage(movieDetail),
                SizedBox(height: 16.h),
                _buildOverviewSection(movieDetail),
                SizedBox(height: 24.h),
                _buildGenresSection(movieDetail),
                SizedBox(height: 24.h),
                _buildWatchedToggle(),
                SizedBox(height: 24.h),
                _buildRatingSection(movieDetail),
                SizedBox(height: 24.h),
                _buildProductionCompaniesSection(movieDetail),
                SizedBox(height: 24.h),
                _buildWatchProvidersSection(),
                SizedBox(height: 24.h),
                _buildCreditsSection(),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBannerImage(MovieDetail? movieDetail) {
    return Container(
      width: double.infinity,
      height: 300.h,
      decoration: BoxDecoration(
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
      child: Text(
        movieDetail?.overview.isNotEmpty == true
            ? movieDetail!.overview
            : 'No overview available.',
        style: TextStyle(fontSize: 14.sp, color: Colors.white),
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
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              genre.name,
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWatchedToggle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: 120.w,
        height: 40.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          'Mark as Watched',
          style: TextStyle(fontSize: 14.sp, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRatingSection(MovieDetail? movieDetail) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.amber, size: 24.sp),
          SizedBox(width: 8.w),
          Text(
            movieDetail?.voteAverage.toStringAsFixed(1) ?? '-',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            '(${movieDetail?.voteCount ?? 0})',
            style: TextStyle(fontSize: 14.sp, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildProductionCompaniesSection(MovieDetail? movieDetail) {
    if (movieDetail == null || movieDetail.productionCompanies.isEmpty) {
      return SizedBox.shrink();
    }

    return SizedBox(
      height: 60.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemCount: movieDetail.productionCompanies.length,
        itemBuilder: (context, index) {
          final company = movieDetail.productionCompanies[index];
          return Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              image: company.logoPath != null
                  ? DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w200${company.logoPath}',
                      ),
                      fit: BoxFit.contain,
                    )
                  : null,
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(8.r),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWatchProvidersSection() {
    return SizedBox(
      height: 60.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemCount: 5,
        itemBuilder: (context, index) =>
            Container(width: 60.w, height: 60.h, color: Colors.grey[700]),
      ),
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
          Text(
            'Tap to view full cast and crew.',
            style: TextStyle(fontSize: 14.sp, color: Colors.white70),
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
