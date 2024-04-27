import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    // Define base colors for light theme
    const Color primaryColor = Color(0xFF265ED7);
    const Color secondaryColor = Color(0xFFE76F51);
    const Color backgroundColor = Color(0xFFF1F1F1);
    const Color textColor = Colors.black87;

    // Define text themes for light theme
    const TextTheme textTheme = TextTheme(
      displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: textColor),
      displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: textColor),
      displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: textColor),
      headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: textColor),
      headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: textColor),
      titleLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: textColor),
      bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: textColor),
      bodyMedium: TextStyle(fontSize: 12.0, color: textColor),
      labelLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
    );

    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        color: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: textTheme.titleLarge?.copyWith(color: Colors.white),
      ),
      textTheme: textTheme,
      buttonTheme: ButtonThemeData(
        buttonColor: secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor),
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        shadowColor: Colors.black12,
        elevation: 3,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static ThemeData get darkTheme {
    // Define base colors for dark theme
    const Color primaryColor = Color(0xFF1E1E1E);
    const Color secondaryColor = Color(0xFF64FFDA);
    const Color backgroundColor = Color(0xFF121212);
    const Color textColor = Colors.white70;

    // Define text themes for dark theme
    const TextTheme textTheme = TextTheme(
      displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: textColor),
      displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: textColor),
      displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: textColor),
      headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: textColor),
      headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: textColor),
      titleLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: textColor),
      bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: textColor),
      bodyMedium: TextStyle(fontSize: 12.0, color: textColor),
      labelLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: primaryColor),
    );

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        color: primaryColor,
        iconTheme: const IconThemeData(color: textColor),
        titleTextStyle: textTheme.titleLarge?.copyWith(color: textColor),
      ),
      textTheme: textTheme,
      buttonTheme: ButtonThemeData(
        buttonColor: secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textColor.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textColor),
        ),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF2C2C2C),
        shadowColor: Colors.black54,
        elevation: 3,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
