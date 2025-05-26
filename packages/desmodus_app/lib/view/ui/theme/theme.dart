import 'package:desmodus_app/view/ui/theme/colors.dart';
import 'package:desmodus_app/view/ui/theme/fonts.dart';
import 'package:flutter/material.dart';

const _sharedTextTheme = TextTheme(
  titleLarge: TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 32,
  ),
  titleMedium: TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  ),
  labelMedium: TextStyle(fontFamily: AppFonts.primaryFont, fontSize: 18),
  headlineLarge: TextStyle(fontFamily: AppFonts.primaryFont),
  headlineSmall: TextStyle(fontFamily: AppFonts.primaryFont),
);

final appTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: AppColors.primaryColor,
  ),
  textTheme: _sharedTextTheme,
).copyWith(iconTheme: const IconThemeData(color: AppColors.primaryColor));

final darkAppTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: AppColors.primaryColor,
  ),
  textTheme: _sharedTextTheme,
).copyWith(
  scaffoldBackgroundColor: AppColors.darkBackgroundColor,
  dialogBackgroundColor: AppColors.darkBackgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.secondaryDarkBackgroundColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.secondaryDarkBackgroundColor,
  ),
  iconTheme: const IconThemeData(color: AppColors.primaryColor),
);
