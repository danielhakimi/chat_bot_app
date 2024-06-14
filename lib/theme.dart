import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static const Color secondary = Color(0xFF3B76F6);
  static const Color accent = Color(0xFFD6755B);
  static const Color textDark = Color(0xFF53585A);
  static const Color textLigth = Color(0xFFF5F5F5);
  static const Color textFaded = Color(0xFF9899A5);
  static const Color iconLight = Color(0xFFB1B4C0);
  static const Color iconDark = Color(0xFFB1B3C1);
  static const Color textHighlight = secondary;
  static const Color cardLight = Color(0xFFF9FAFE);
  static const Color cardDark = Color(0xFF303334);
}

abstract class _LightColors {
  static const Color background = Colors.white;
  static const Color card = AppColors.cardLight;
}

abstract class _DarkColors {
  static const Color background = Color(0xFF1B1E1F);
  static const Color card = AppColors.cardDark;
}

/// Reference to the application theme.
class AppTheme {
  static const Color accentColor = AppColors.accent;
  static final VisualDensity visualDensity = VisualDensity.adaptivePlatformDensity;

  final ThemeData darkBase = ThemeData.dark();
  final ThemeData lightBase = ThemeData.light();

  /// Light theme and its settings.
  ThemeData get light => ThemeData(
        brightness: Brightness.light,
        visualDensity: visualDensity,
        textTheme: GoogleFonts.mulishTextTheme().apply(bodyColor: AppColors.textDark),
        appBarTheme: lightBase.appBarTheme.copyWith(
          iconTheme: lightBase.iconTheme,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: AppColors.textDark,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        scaffoldBackgroundColor: _LightColors.background,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
        ),
        cardColor: _LightColors.card,
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(color: AppColors.textDark),
        ),
        iconTheme: const IconThemeData(color: AppColors.iconDark),
        colorScheme: lightBase.colorScheme.copyWith(secondary: accentColor).copyWith(background: _LightColors.background),
      );

  /// Dark theme and its settings.
  ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        visualDensity: visualDensity,
        textTheme: GoogleFonts.interTextTheme().apply(bodyColor: AppColors.textLigth),
        appBarTheme: darkBase.appBarTheme.copyWith(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        scaffoldBackgroundColor: _DarkColors.background,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
        ),
        cardColor: _DarkColors.card,
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(color: AppColors.textLigth),
        ),
        iconTheme: const IconThemeData(color: AppColors.iconLight),
        colorScheme: darkBase.colorScheme.copyWith(secondary: accentColor).copyWith(background: _DarkColors.background),
      );
}
