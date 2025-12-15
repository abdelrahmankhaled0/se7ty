import 'package:flutter/material.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.primaryColor,
      ),
      fontFamily: AppFonts.cairoFont,
      scaffoldBackgroundColor: AppColors.lightColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightColor,
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1, color: AppColors.redColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1.5, color: AppColors.redColor),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData();
  }
}
