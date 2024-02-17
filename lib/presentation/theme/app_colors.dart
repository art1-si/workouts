import 'package:flutter/widgets.dart';

class AppColors {
  static const Color accent = Color.fromARGB(255, 70, 110, 253);
  static const Color accentSecondary = Color.fromARGB(255, 126, 79, 255);
  static const int _primaryShadeValue = 0xFF1E1E1E;
  static const BasicsColor primaryShades = BasicsColor(_primaryShadeValue, <int, Color>{
    70: Color(0xFFEAEAEA),
    80: Color(0xFF555555),
    90: Color(0xFF292929),
    100: Color(0xFF1F1F1F),
    110: Color(0xFF171717),
  });
}

class BasicsColor extends ColorSwatch<int> {
  const BasicsColor(super.primary, super.swatch);

  Color get shade10 => this[10]!;
  Color get shade20 => this[20]!;
  Color get shade30 => this[30]!;
  Color get shade40 => this[40]!;
  Color get shade50 => this[50]!;
  Color get shade60 => this[60]!;
  Color get shade70 => this[70]!;
  Color get shade80 => this[80]!;
  Color get shade90 => this[90]!;
  Color get shade100 => this[100]!;
  Color get shade110 => this[110]!;
  Color get shade120 => this[120]!;
  Color get shade130 => this[130]!;
  Color get shade140 => this[140]!;
  Color get shade150 => this[150]!;
  Color get shade160 => this[160]!;
  Color get shade170 => this[170]!;
  Color get shade180 => this[180]!;
  Color get shade190 => this[190]!;
  Color get shade200 => this[200]!;
}
