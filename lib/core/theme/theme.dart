
import 'package:bloc_clean_architecture_tdd_solid/core/theme/color.pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = ColorPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorPallete.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(
        ColorPallete.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(ColorPallete.gradient2),
      errorBorder: _border(ColorPallete.errorColor),
    ),
  );
}
