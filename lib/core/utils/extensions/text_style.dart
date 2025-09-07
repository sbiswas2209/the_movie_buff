import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    FontStyle? fontStyle,
    String? fontFamily,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      color: color ?? this.color,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      height: height ?? this.height,
      fontStyle: fontStyle ?? this.fontStyle,
      fontFamily: fontFamily ?? this.fontFamily,
      decoration: decoration ?? this.decoration,
    );
  }

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);

  TextStyle get overline => copyWith(decoration: TextDecoration.overline);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withFontSize(double size) => copyWith(fontSize: size);

  TextStyle withLetterSpacing(double spacing) =>
      copyWith(letterSpacing: spacing);

  TextStyle withHeight(double height) => copyWith(height: height);

  TextStyle withFontWeight(FontWeight weight) => copyWith(fontWeight: weight);

  TextStyle withFontStyle(FontStyle style) => copyWith(fontStyle: style);

  TextStyle withFontFamily(String family) => copyWith(fontFamily: family);
}
