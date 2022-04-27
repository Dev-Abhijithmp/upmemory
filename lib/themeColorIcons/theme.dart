import 'package:flutter/material.dart';
import 'package:upmemory/themeColorIcons/colors.dart';

class ColorsS {
  const ColorsS();

  static Color loginGradientStart = const Color(0xFFf7418c);
  static Color loginGradientEnd = endClr;

  static var primaryGradient = LinearGradient(
    colors: [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
