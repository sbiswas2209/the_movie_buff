import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:the_movie_buff/core/services/config_service.dart';
import 'package:the_movie_buff/core/styles/themes.dart';
import 'package:the_movie_buff/core/styles/typography.dart';
import 'package:the_movie_buff/core/utils/find_nearest_size.dart';
import 'package:the_movie_buff/gen/assets.gen.dart';

class PopularMovieCard extends StatelessWidget {
  final String? imagePath;
  final String title;
  final List<String> genres;
  final double rating;
  final int ratings;
  final VoidCallback onPressed;

  const PopularMovieCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onPressed,
    required this.genres,
    required this.rating,
    required this.ratings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: kSecondaryColor,
      ),
      child: Column(
        children: [
          Container(
            width: 1.sw,
            height: 200,
            child: imagePath == null
                ? Assets.images.backdropPlaceholder.image()
                : CachedNetworkImage(
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
          Text(title, style: kHeading6),
          Expanded(
            child: Wrap(
              children: genres
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 1.h,
                      ).copyWith(right: 5.w),
                      child: Chip(
                        label: Text(e),
                        labelStyle: kSmall1.copyWith(color: kOnTertiaryColor),
                        labelPadding: EdgeInsets.symmetric(vertical: 2.w),
                        backgroundColor: kTertiaryColor,
                        side: BorderSide.none,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
