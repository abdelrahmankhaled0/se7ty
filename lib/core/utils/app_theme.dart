import 'package:flutter/material.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_fonts.dart';

class AppTheme {
  static ThemeData get lighttheme {
    return ThemeData(
      fontFamily: AppFonts.cairoFont,
      scaffoldBackgroundColor: AppColors.lightColor,
      appBarTheme: AppBarThemeData(backgroundColor: AppColors.lightColor),
      inputDecorationTheme: InputDecorationThemeData(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1, color: AppColors.secondryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1, color: AppColors.secondryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1, color: AppColors.secondryColor),
        ),
      ),
    );
  }

  static darkTheme() {
    return null;
  }
}
