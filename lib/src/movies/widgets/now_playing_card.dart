import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:the_movie_buff/core/services/config_service.dart';
import 'package:the_movie_buff/core/styles/themes.dart';
import 'package:the_movie_buff/core/styles/typography.dart';
import 'package:the_movie_buff/core/utils/extensions/text_style.dart';
import 'package:the_movie_buff/core/utils/find_nearest_size.dart';
import 'package:the_movie_buff/gen/assets.gen.dart';

class NowPlayingCard extends StatelessWidget {
  final String? posterPath;
  final String title;
  final double voteAverage;
  final bool adult;
  final VoidCallback? onPressed;
  final bool _showShimmer;

  const NowPlayingCard({
    super.key,
    required this.title,
    required this.voteAverage,
    required this.onPressed,
    this.posterPath,
    this.adult = false,
  }) : _showShimmer = false;

  const NowPlayingCard.shimmer({super.key})
    : title = '',
      voteAverage = 0.0,
      posterPath = null,
      adult = false,
      onPressed = null,
      _showShimmer = true;

  @override
  Widget build(BuildContext context) {
    if (_showShimmer) {
      return _buildShimmer();
    }
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Stack(
                children: [
                  posterPath == null
                      ? Assets.images.posterPlaceholder.image(
                          fit: BoxFit.fitWidth,
                          width: double.maxFinite,
                        )
                      : CachedNetworkImage(
                          width: double.maxFinite,
                          imageUrl:
                              "${ConfigService.instance.imageBaseUrl}${findNearestPosterSize(MediaQuery.of(context).size.width)}$posterPath",
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) => Shimmer(
                            duration: Duration(seconds: 2),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8.r),
                                ),
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Assets
                              .images
                              .posterPlaceholder
                              .image(fit: BoxFit.cover),
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
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6.h),
                Text(
                  title,
                  style: kHeading4.bold,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.star, color: kPrimaryColor, size: 16.sp),
                    SizedBox(width: 2.w),
                    Text(
                      voteAverage.toStringAsFixed(1),
                      style: kParagraph2.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer(
      duration: Duration(seconds: 2),
      child: Card(
        color: kSecondaryColor,
        elevation: 4,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8.r),
                  ),
                  color: Colors.grey[300],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12.h,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      height: 10.h,
                      width: 80.w,
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
