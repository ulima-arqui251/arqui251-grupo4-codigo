import 'package:flutter/material.dart';

class AppColors {
  const AppColors(BuildContext context);

  static const Color backgroundColor = Color.fromARGB(255, 221, 245, 230);
  static const Color darkBackgroundColor = Color.fromARGB(255, 2, 6, 16);
  static const Color secondaryDarkBackgroundColor =
      Color.fromARGB(255, 24, 24, 27);

  static const Color primaryColor = Color.fromARGB(255, 82, 178, 37);
  static const Color secondaryColor = Color.fromARGB(255, 187, 255, 131);

  static const Color dangerColor = Color.fromARGB(255, 255, 0, 0);
  static const Color warningColor = Color.fromARGB(255, 255, 166, 0);

  static const Color textColor = Color(0xFF262F34);

  static const List<Color> backgroundLinearGradientColors = [
    Color(0xFFD3F1DF),
    Color.fromARGB(255, 255, 255, 255),
    Color(0xFFD3F1DF),
  ];

  static const List<Color> darkBackgroundLinearGradientColors = [
    Color(0x001F4529),
    Color.fromARGB(78, 128, 37, 37),
    Color(0x001F4529),
  ];
}
