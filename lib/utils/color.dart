
import 'dart:math';

import 'package:flutter/material.dart';

import '../local_data_source/shared_preference.dart';

class AppThemeHelper {
  static bool get isDarkMode => SharedPref.getBool("isDarkMode") ?? false;

  static Color get background =>
      isDarkMode ?  Color(0xFF252525) :  Color(0xFFF8F9FA);

  static Color get foreground =>
      isDarkMode ? Colors.white : const Color(0xFF212121);

  static Color get fabBackground =>
      isDarkMode ? Colors.black : const Color(0xFFFF7043);

  static Color get fabForeground =>
      isDarkMode ? Colors.white70 : Colors.white;

  static Color get textFieldHint =>
      isDarkMode ? Colors.white60 : const Color(0xFF9E9E9E);

  static Color get textFieldText =>
      isDarkMode ? Colors.white : const Color(0xFF424242);

  static Color get icon =>
      isDarkMode ? Colors.white70 : const Color(0xFF616161);

  static Color get card =>
      isDarkMode ? const Color(0xFF3B3B3B) : const Color(0xFFF1F1F1);
  static Color get importantCard =>
      isDarkMode ? const Color(0xFF3949AB) : const Color(0xFFAED6F1);
}




class ColorGenerator {
  static final Random _random = Random();

  static List<Color> generateHarmoniousColors({
    int count = 5,
    bool preferDarkForeground = true,
  }) {
    double baseHue = _random.nextDouble() * 360;
    List<Color> colors = [];

    for (int i = 0; i < count; i++) {
      double hue = (baseHue + (i * 25)) % 360;

      double saturation = 0.5 + _random.nextDouble() * 0.2; 
      double lightness = preferDarkForeground
          ? 0.65 + _random.nextDouble() * 0.1
          : 0.35 + _random.nextDouble() * 0.1;

      colors.add(HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor());
    }

    return colors;
  }
}


