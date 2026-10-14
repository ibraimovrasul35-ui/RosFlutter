import 'package:flutter/material.dart';

/// Собственные темы приложения: светлая и тёмная.
class AppTheme {
  static const _seed = Color(0xFFE76F51);

  static ThemeData light = _build(Brightness.light);
  static ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: brightness);
    return ThemeData(
      colorScheme: scheme,
      fontFamily: 'Nunito',
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scheme.surface,
        titleTextStyle: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: scheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontWeight: FontWeight.w800),
        titleLarge: TextStyle(fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
