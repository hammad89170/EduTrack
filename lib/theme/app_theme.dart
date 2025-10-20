import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color accentColor = Color(0xFF42A5F5);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF212121);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.light(primary: primaryColor, secondary: accentColor),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: textColor, fontSize: 16),
      titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
    ),
  );
}
