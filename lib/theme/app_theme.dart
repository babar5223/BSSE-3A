import 'package:flutter/material.dart';

const Color kGold = Color(0xFFD4AF37);
const Color kDeepBlue = Color(0xFF1A237E);
const Color kDarkBg = Color(0xFF0A0A0A);
const Color kDarkSurface = Color(0xFF1C1C1E);
const Color kDarkCard = Color(0xFF2C2C2E);
const Color kLightBg = Color(0xFFFAFAFA);
const Color kLightCard = Color(0xFFFFFFFF);
const Color kTextDark = Color(0xFF1A1A1A);
const Color kTextLight = Color(0xFFF5F5F5);
const Color kSubtextDark = Color(0xFF6B6B6B);
const Color kSubtextLight = Color(0xFFAAAAAA);

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: kLightBg,
    primaryColor: kDeepBlue,
    colorScheme: const ColorScheme.light(
      primary: kDeepBlue,
      secondary: kGold,
      surface: kLightCard,
      background: kLightBg,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kLightBg,
      foregroundColor: kTextDark,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: _buildTextTheme(kTextDark, kSubtextDark),
    cardTheme: CardTheme(
      color: kLightCard,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kDeepBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kGold, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    useMaterial3: false,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kDarkBg,
    primaryColor: kGold,
    colorScheme: const ColorScheme.dark(
      primary: kGold,
      secondary: kDeepBlue,
      surface: kDarkSurface,
      background: kDarkBg,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kDarkBg,
      foregroundColor: kTextLight,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: _buildTextTheme(kTextLight, kSubtextLight),
    cardTheme: CardTheme(
      color: kDarkCard,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kGold,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kGold, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      fillColor: kDarkCard,
      filled: true,
    ),
    useMaterial3: false,
  );

  static TextTheme _buildTextTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: TextStyle(
          fontSize: 48, fontWeight: FontWeight.w800, color: primary, letterSpacing: -1),
      displayMedium: TextStyle(
          fontSize: 36, fontWeight: FontWeight.w700, color: primary, letterSpacing: -0.5),
      displaySmall: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w700, color: primary),
      headlineLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w700, color: primary),
      headlineMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: primary),
      headlineSmall: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: primary),
      titleLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: primary),
      titleMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: primary),
      titleSmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: secondary),
      bodyLarge: TextStyle(fontSize: 16, color: primary, height: 1.6),
      bodyMedium: TextStyle(fontSize: 14, color: secondary, height: 1.5),
      bodySmall: TextStyle(fontSize: 12, color: secondary),
      labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: primary),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
