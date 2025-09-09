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

class SearchResultTile extends StatelessWidget {
  final int id;
  final String title;
  final String? posterPath;
  final void Function(int) onPressed;

  final bool _showShimmer;

  const SearchResultTile({
    super.key,
    required this.id,
    required this.title,
    required this.onPressed,
    this.posterPath,
  }) : _showShimmer = false;

  const SearchResultTile.shimmer({super.key})
    : id = -1,
      title = '',
      posterPath = null,
      onPressed = _emptyCallback,
      _showShimmer = true;

  static void _emptyCallback(int _) {}

  @override
  Widget build(BuildContext context) {
    if (_showShimmer) {
      return _buildShimmer();
    }
    return ListTile(
      tileColor: kBackgroundColor,
      onTap: () => onPressed(id),
      leading: Container(
        width: 40.w,
        height: 75.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          image: DecorationImage(
            image: posterPath == null
                ? Assets.images.posterPlaceholder.provider()
                : CachedNetworkImageProvider(
                    "${ConfigService.instance.imageBaseUrl}${findNearestPosterSize(40.w)}$posterPath}",
                  ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(title, style: kParagraph2.withColor(kOnPrimaryColor)),
    );
  }

  Widget _buildShimmer() {
    return ListTile(
      tileColor: kBackgroundColor,
      onTap: null,
      leading: Shimmer(
        child: Container(
          width: 50.w,
          height: 75.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
        ),
      ),
      title: Shimmer(
        child: SizedBox(width: double.infinity, height: 14.h),
      ),
    );
  }
}
