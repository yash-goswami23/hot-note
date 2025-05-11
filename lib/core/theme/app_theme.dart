import 'package:flutter/material.dart';
import 'package:hot_note/core/theme/app_colors.dart';

class AppTheme {
  // Custom border with smooth animation
  static InputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: color.withOpacity(0.8), width: 1.5),
    gapPadding: 8,
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.dark(
      primary: AppColors.surface,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: _border(AppColors.textSecondary),
      enabledBorder: _border(AppColors.textSecondary),
      focusedBorder: _border(AppColors.textPrimary).copyWith(
        borderSide: BorderSide(color: AppColors.textPrimary, width: 2.0),
      ),
      hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
      labelStyle: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14,
        letterSpacing: 0.5,
      ),
      floatingLabelStyle: TextStyle(
        color: AppColors.accent,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      suffixIconColor: AppColors.textSecondary,
      prefixIconColor: AppColors.textSecondary,
      errorStyle: TextStyle(fontWeight: FontWeight.w500),
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
