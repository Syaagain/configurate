import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6A4C93);
  static const Color primaryLight = Color(0xFF9B7BAE);
  static const Color primaryDark = Color(0xFF4A3268);
  
  // Accent Colors
  static const Color accent = Color(0xFFFF6B9D);
  static const Color accentLight = Color(0xFFFF8FAB);
  static const Color accentDark = Color(0xFFE54980);
  
  // Gradient Colors
  static const List<Color> backgroundGradient = [
    Color(0xFF6A4C93),
    Color(0xFF9B59B6),
    Color(0xFFE91E63),
    Color(0xFFFF9800),
  ];
  
  static const List<double> backgroundGradientStops = [0.0, 0.3, 0.7, 1.0];
  
  // Media Type Colors
  static const Color videoColor = Color(0xFFE53E3E);
  static const Color imageColor = Color(0xFF38A169);
  static const Color audioColor = Color(0xFF805AD5);
  static const Color documentColor = Color(0xFF3182CE);
  
  // Status Colors
  static const Color successColor = Color(0xFF48BB78);
  static const Color warningColor = Color(0xFFED8936);
  static const Color errorColor = Color(0xFFE53E3E);
  static const Color infoColor = Color(0xFF3182CE);
  
  // Neutral Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey50 = Color(0xFFF7FAFC);
  static const Color grey100 = Color(0xFFEDF2F7);
  static const Color grey200 = Color(0xFFE2E8F0);
  static const Color grey300 = Color(0xFFCBD5E0);
  static const Color grey400 = Color(0xFFA0AEC0);
  static const Color grey500 = Color(0xFF718096);
  static const Color grey600 = Color(0xFF4A5568);
  static const Color grey700 = Color(0xFF2D3748);
  static const Color grey800 = Color(0xFF1A202C);
  static const Color grey900 = Color(0xFF171923);
}