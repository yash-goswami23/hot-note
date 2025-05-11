import 'dart:ui';

class AppColors {
  // Secondary/Action Colors
  static const Color secondary = Color(0xFF43A047); // Muted Green
  static const Color accent = Color(0xFFD81B60); // Darker Pink

  // Background & Surface
  static const Color background = Color(
    0xFF121212,
  ); // True Black-800 (Material Dark)
  static const Color surface = Color(0xFF1E1E1E); // Dark Grey

  // Text Colors
  static const Color textPrimary = Color(
    0xFFE0E0E0,
  ); // Light Grey (87% opacity)
  static const Color textSecondary = Color(0xFF9E9E9E); // Grey (60% opacity)
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White
  static const Color disabled = Color(0xFF616161); // Grey

  // Task Status Indicators
  static const Color queued = Color(0xFFFFB74D); // Soft Orange
  static const Color uploaded = Color(0xFF81C784); // Muted Green
}
