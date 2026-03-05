import 'package:flutter/material.dart';

/// Tema aplikasi bergaya clean & minimalis ala shadcn/ui:
/// - Palet netral (slate/zinc), border halus, radius konsisten.
class AppTheme {
  AppTheme._();

  // --- Warna netral ala shadcn (light)
  static const Color _background = Color(0xFFFAFAFA);
  static const Color _foreground = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFFFFFFFF);
  static const Color _border = Color(0xFFE5E5E5);
  static const Color _muted = Color(0xFFF5F5F5);
  static const Color _mutedForeground = Color(0xFF737373);
  static const Color _primary = Color(0xFF18181B);
  static const Color _primaryForeground = Color(0xFFFAFAFA);
  static const Color _ring = Color(0xFF18181B);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        surface: _background,
        onSurface: _foreground,
        surfaceContainerHighest: _card,
        outline: _border,
        primary: _primary,
        onPrimary: _primaryForeground,
        secondary: _muted,
        onSecondary: _mutedForeground,
        error: const Color(0xFFDC2626),
        onError: const Color(0xFFFAFAFA),
      ),
      scaffoldBackgroundColor: _background,
      cardTheme: CardThemeData(
        color: _card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: _border, width: 1),
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _card,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _ring, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFDC2626)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFDC2626), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        labelStyle: const TextStyle(color: _mutedForeground, fontSize: 14),
        hintStyle: const TextStyle(color: _mutedForeground, fontSize: 14),
        errorStyle: const TextStyle(color: Color(0xFFDC2626), fontSize: 12),
        floatingLabelStyle: const TextStyle(color: _foreground, fontSize: 14),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: _primaryForeground,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _foreground,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _background,
        foregroundColor: _foreground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _card,
        elevation: 0,
        height: 64,
        indicatorColor: _muted,
        surfaceTintColor: Colors.transparent,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: _card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: _border, width: 1),
        ),
      ),
    );
  }
}
