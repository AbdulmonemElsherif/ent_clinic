import 'package:ent_clinic/core/routes/routes.dart';
import 'package:ent_clinic/core/theme/colors.dart'; // Make sure this file has appThemeData defined
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class EntClinicalApp extends StatelessWidget {
  const EntClinicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightThemeData, // Use lightThemeData
      dark: darkThemeData, // Use darkThemeData
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'ENT Clinic',
        initialRoute: AppRoutes.doctor,
        theme: theme,
        darkTheme: darkTheme,
        routes: routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
