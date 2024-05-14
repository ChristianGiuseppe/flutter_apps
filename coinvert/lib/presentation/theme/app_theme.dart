import 'package:coinvert/presentation/style/app_color_styles.dart';
import 'package:coinvert/presentation/style/app_text_styles.dart';
import 'package:coinvert/presentation/theme/text_theme.dart';
import 'package:flutter/material.dart';

final ThemeData appThemeDataLight = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: AppColorLight.primary,
    secondary: AppColorLight.secondary,
    surface: AppColorLight.surface,
    background: AppColorLight.background,
    error: AppColorLight.error,
    onPrimary: AppColorLight.onPrimary,
    onSecondary: AppColorLight.onSecondary,
    onSurface: AppColorLight.onSurface,
    onBackground: AppColorLight.onBackground,
    onError: AppColorLight.error,
  ),
  textTheme: textThemeLight,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColorLight.primary, width: 1.0),
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  cardColor: AppColorLight.background,
  cardTheme: const CardTheme(
    color: AppColorLight.background,
    shadowColor: null,
    elevation: 2,
    surfaceTintColor: AppColorLight.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: AppTextStylesLight.labelSmall,
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(AppColorLight.background),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColorLight.primary, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(16.0),
      ),
      activeIndicatorBorder:
          const BorderSide(color: AppColorLight.primary, width: 1.0),
      outlineBorder: const BorderSide(color: AppColorLight.primary, width: 1.0),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColorLight.primary, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
  ),
);

final ThemeData appThemeDataDark = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: AppColorDark.primary,
    secondary: AppColorDark.secondary,
    surface: AppColorDark.surface,
    background: AppColorDark.background,
    error: AppColorDark.error,
    onPrimary: AppColorDark.onPrimary,
    onSecondary: AppColorDark.onSecondary,
    onSurface: AppColorDark.onSurface,
    onBackground: AppColorDark.onBackground,
    onError: AppColorDark.error,
  ),
  textTheme: textThemeDark,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColorDark.primary, width: 1.0),
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  cardColor: AppColorDark.background,
  cardTheme: const CardTheme(
    shadowColor: null,
    elevation: 0,
    surfaceTintColor: AppColorDark.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(AppColorDark.background),
    ),
    textStyle:
        AppTextStylesDark.labelSmall.copyWith(color: AppColorDark.primary),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColorDark.primary, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(16.0),
      ),
      activeIndicatorBorder:
          const BorderSide(color: AppColorDark.primary, width: 1.0),
      outlineBorder: const BorderSide(color: AppColorDark.primary, width: 1.0),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColorDark.primary, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
  ),
);
