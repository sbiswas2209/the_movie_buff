import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie_buff/core/styles/themes.dart';
import 'package:the_movie_buff/core/styles/typography.dart';

enum GenreChipVariant { normal, large }

class GenreChip extends StatelessWidget {
  final String genre;
  final GenreChipVariant variant;

  const GenreChip({
    super.key,
    required this.genre,
    this.variant = GenreChipVariant.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: kTertiaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: variant == GenreChipVariant.normal ? 4.w : 6.w,
          vertical: variant == GenreChipVariant.normal ? 2.h : 4.h,
        ),
        child: Text(
          genre,
          style: (variant == GenreChipVariant.normal ? kSmall1 : kParagraph1)
              .copyWith(color: kOnTertiaryColor),
        ),
      ),
    );
  }
}
