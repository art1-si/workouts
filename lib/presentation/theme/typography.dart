import 'package:flutter/material.dart';

class StyledText extends Text {
  const StyledText(
    super.data, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaleFactor,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  });

  factory StyledText.headlineSmall(String data) {
    return StyledText(data, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold));
  }

  factory StyledText.headlineMedium(String data) {
    return StyledText(data, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold));
  }

  factory StyledText.headline1(String data) {
    return StyledText(data,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ));
  }

  factory StyledText.headline(String data) {
    return StyledText(data, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold));
  }

  factory StyledText.body(String data, {FontWeight? fontWeight}) {
    return StyledText(data, style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: fontWeight));
  }

  factory StyledText.bodyLarge(String data, {FontWeight? fontWeight, Color? color}) {
    return StyledText(data, style: TextStyle(fontSize: 18, color: color ?? Colors.white, fontWeight: fontWeight));
  }

  factory StyledText.labelLarge(String data) {
    return StyledText(data, style: const TextStyle(fontSize: 16, color: Colors.white));
  }

  factory StyledText.labelMedium(String data, {Color? color}) {
    return StyledText(data, style: TextStyle(fontSize: 14, color: color ?? Colors.white));
  }

  factory StyledText.labelSemiMedium(String data, {Color? color}) {
    return StyledText(data, style: TextStyle(fontSize: 12, color: color ?? Colors.white));
  }

  factory StyledText.labelSmall(String data, {Color? color}) {
    return StyledText(data, style: TextStyle(fontSize: 10, color: color ?? Colors.white));
  }

  factory StyledText.button(String data, {Color? color}) {
    return StyledText(data, style: TextStyle(fontSize: 14, color: color ?? Colors.white, fontWeight: FontWeight.bold));
  }
}
