import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:the_movie_buff/core/services/config_service.dart';
import 'package:the_movie_buff/core/styles/themes.dart';
import 'package:the_movie_buff/core/styles/typography.dart';
import 'package:the_movie_buff/core/utils/extensions/text_style.dart';
import 'package:the_movie_buff/core/utils/find_nearest_size.dart';
import 'package:the_movie_buff/gen/assets.gen.dart';

class PopularMovieCard extends StatelessWidget {
  final String? imagePath;
  final String title;
  final List<String> genres;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final VoidCallback onPressed;
  final bool adult;
  final bool isShimmer;

  const PopularMovieCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onPressed,
    required this.genres,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    this.adult = false,
  }) : isShimmer = false;

  const PopularMovieCard.shimmer({super.key})
    : title = '',
      imagePath = null,
      genres = const [],
      releaseDate = '',
      voteAverage = 0.0,
      voteCount = 0,
      onPressed = _emptyCallback,
      adult = false,
      isShimmer = true;

  static void _emptyCallback() {}

  @override
  Widget build(BuildContext context) {
    if (isShimmer) {
      return _buildShimmer();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: kSecondaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: imagePath == null
                        ? Assets.images.backdropPlaceholder.image(
                            fit: BoxFit.fitHeight,
                          )
                        : CachedNetworkImage(
                            fit: BoxFit.fitHeight,
                            height: MediaQuery.of(context).size.height,
                            imageUrl:
                                "${ConfigService.instance.imageBaseUrl}${findNearestPosterSize(1.sw)}$imagePath",
                            placeholder: (context, _) {
                              return Shimmer(child: Container());
                            },
                            errorWidget: (context, _, __) {
                              return Assets.images.backdropPlaceholder.image();
                            },
                          ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
                if (adult)
                  Positioned(
                    top: 2.h,
                    right: 2.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      margin: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "18+",
                        style: kParagraph2.withColor(Colors.white).semiBold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: kHeading2.bold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  _buildSecondaryRow(),
                  SizedBox(height: 4.h),
                  _buildTertiaryRow(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryRow() {
    return Text(
      "${Jiffy.parse(releaseDate).fromNow()} • ${[...genres.sublist(0, genres.length > 3 ? 3 : genres.length), if (genres.length > 3) '+${genres.length - 3}'].join(", ")}",
      style: kParagraph2.withColor(kOnSecondaryColor).semiBold,
    );
  }

  Widget _buildTertiaryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.star_rounded, color: kPrimaryColor, size: 24.sp),
        SizedBox(width: 4.w),
        Text(voteAverage.toStringAsFixed(1), style: kHeading3.bold),
        SizedBox(width: 6.w),
        Text(
          voteCount.toString(),
          style: kParagraph1.withColor(kOnSecondaryColor).semiBold,
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Shimmer(
      duration: Duration(seconds: 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.grey[300],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.grey[300],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 16.h,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 12.h,
                      width: 150.w,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 12.h,
                      width: 100.w,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
