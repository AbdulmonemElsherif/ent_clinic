import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006590),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFC8E6FF),
  onPrimaryContainer: Color(0xFF001E2F),
  secondary: Color(0xFF005CBC),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD7E2FF),
  onSecondaryContainer: Color(0xFF001B3F),
  tertiary: Color(0xFF00658E),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFC7E7FF),
  onTertiaryContainer: Color(0xFF001E2E),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFDFBFF),
  onBackground: Color(0xFF001B3D),
  surface: Color(0xFFFDFBFF),
  onSurface: Color(0xFF001B3D),
  surfaceVariant: Color(0xFFDDE3EA),
  onSurfaceVariant: Color(0xFF41474D),
  outline: Color(0xFF71787E),
  onInverseSurface: Color(0xFFECF0FF),
  inverseSurface: Color(0xFF003062),
  inversePrimary: Color(0xFF89CEFF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006590),
  outlineVariant: Color(0xFFC1C7CE),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF89CEFF),
  onPrimary: Color(0xFF00344D),
  primaryContainer: Color(0xFF004C6E),
  onPrimaryContainer: Color(0xFFC8E6FF),
  secondary: Color(0xFFABC7FF),
  onSecondary: Color(0xFF002F66),
  secondaryContainer: Color(0xFF00458F),
  onSecondaryContainer: Color(0xFFD7E2FF),
  tertiary: Color(0xFF84CFFF),
  onTertiary: Color(0xFF00344C),
  tertiaryContainer: Color(0xFF004C6C),
  onTertiaryContainer: Color(0xFFC7E7FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001B3D),
  onBackground: Color(0xFFD6E3FF),

  ///MOST OF COLORS

  // surface: Color(0xFF001B3D),
  surface: Color(0xFF000000),

  onSurface: Color(0xFFD6E3FF),
  surfaceVariant: Color(0xFF41474D),
  onSurfaceVariant: Color(0xFFC1C7CE),
  outline: Color(0xFF8B9198),
  onInverseSurface: Color(0xFF001B3D),
  inverseSurface: Color(0xFFD6E3FF),
  inversePrimary: Color(0xFF006590),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF89CEFF),
  outlineVariant: Color(0xFF41474D),
  scrim: Color(0xFF000000),
);

final ThemeData lightThemeData = ThemeData(
  brightness: lightColorScheme.brightness,
  primaryColor: lightColorScheme.primary,
  primaryColorLight: lightColorScheme.primaryContainer,
  primaryColorDark: lightColorScheme.primary,
  secondaryHeaderColor: lightColorScheme.secondary,
  hintColor: lightColorScheme.secondaryContainer,
  scaffoldBackgroundColor: lightColorScheme.surface,
  textTheme: const TextTheme(
      // Define your light theme text styles
      ),
  checkboxTheme: CheckboxThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return lightColorScheme.primary;
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return lightColorScheme.primary;
      }
      return null;
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return lightColorScheme.primary;
      }
      return null;
    }),
    trackColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return lightColorScheme.primary;
      }
      return null;
    }),
  ),
  colorScheme: lightColorScheme
      .copyWith(secondary: lightColorScheme.primary)
      .copyWith(background: lightColorScheme.background),
);

final ThemeData darkThemeData = ThemeData(
  brightness: darkColorScheme.brightness,
  primaryColor: darkColorScheme.primary,
  primaryColorLight: darkColorScheme.primaryContainer,
  primaryColorDark: darkColorScheme.primary,
  secondaryHeaderColor: darkColorScheme.secondary,
  hintColor: darkColorScheme.secondaryContainer,
  scaffoldBackgroundColor: darkColorScheme.surface,
  textTheme: const TextTheme(
      // Define your dark theme text styles
      ),
  checkboxTheme: CheckboxThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return darkColorScheme.primary;
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return darkColorScheme.primary;
      }
      return null;
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return darkColorScheme.primary;
      }
      return null;
    }),
    trackColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return darkColorScheme.primary;
      }
      return null;
    }),
  ),
  colorScheme: darkColorScheme
      .copyWith(secondary: darkColorScheme.primary)
      .copyWith(background: darkColorScheme.background),
);
