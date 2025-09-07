import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_movie_buff/core/utils/extensions/text_style.dart';

const TextStyle _baseStyle = TextStyle(
  fontFamily: 'Quicksand',
  color: Color(0xFFFFFFFF),
);

TextStyle get kBaseTypography => _baseStyle;

TextStyle get kHeading1 => _baseStyle.withFontSize(20.sp);

TextStyle get kHeading2 => _baseStyle.withFontSize(18.sp);

TextStyle get kHeading3 => _baseStyle.withFontSize(16.sp);

TextStyle get kHeading4 => _baseStyle.withFontSize(14.sp);

TextStyle get kHeading6 => _baseStyle.withFontSize(12.sp);

TextStyle get kParagraph1 => _baseStyle.withFontSize(12.sp);

TextStyle get kParagraph2 => _baseStyle.withFontSize(10.sp);

TextStyle get kSmall1 => _baseStyle.withFontSize(8.sp);
