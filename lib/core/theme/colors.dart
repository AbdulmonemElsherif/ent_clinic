import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF1565C0);
  static const primaryColorLight = Color(0xFF5E92F3);
  static const primaryColorDark = Color(0xFF003C8F);
  static const secondaryColor = Color(0xFF42A5F5);
  static const secondaryColorLight = Color(0xFF80D6FF);
  static const secondaryColorDark = Color(0xFF0077C2);
  static const onPrimaryColor = Color(0xFFFFFFFF);
  static const onSecondaryColor = Color(0xFF000000);
}

final ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  primaryColorLight: AppColors.primaryColorLight,
  primaryColorDark: AppColors.primaryColorDark,
  secondaryHeaderColor: AppColors.secondaryColor,
  hintColor: AppColors.secondaryColorLight,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    // Define your light theme text styles
  ),
);

final ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  primaryColorLight: AppColors.primaryColorLight,
  primaryColorDark: AppColors.primaryColorDark,
  secondaryHeaderColor: AppColors.secondaryColor,
  hintColor: AppColors.secondaryColorLight,
  backgroundColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    // Define your dark theme text styles
  ),
);