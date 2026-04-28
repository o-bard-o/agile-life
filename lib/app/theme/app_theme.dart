import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    const colorScheme = ColorScheme.light(
      primary: Color(0xFF111111),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFEDEDE8),
      onPrimaryContainer: Color(0xFF111111),
      secondary: Color(0xFF525252),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFF0F0EC),
      onSecondaryContainer: Color(0xFF1C1C1A),
      tertiary: Color(0xFF737373),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFF4F4F0),
      onTertiaryContainer: Color(0xFF1C1C1A),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF111111),
      surfaceContainerHighest: Color(0xFFF0F0EC),
      onSurfaceVariant: Color(0xFF5F625D),
      outline: Color(0xFF9A9D96),
      outlineVariant: Color(0xFFE4E4DE),
      inverseSurface: Color(0xFF111111),
      onInverseSurface: Color(0xFFFFFFFF),
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Pretendard',
      fontFamilyFallback: const [
        'Apple SD Gothic Neo',
        'Noto Sans KR',
        'sans-serif',
      ],
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFFAFAF7),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: colorScheme.onSurface,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
      ),
      cardTheme: CardTheme(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(44, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(44, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(44, 44),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        height: 72,
        indicatorColor: colorScheme.primaryContainer,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: TextStyle(color: colorScheme.onInverseSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          height: 1.18,
          letterSpacing: 0,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          height: 1.24,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          height: 1.28,
          letterSpacing: 0,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          height: 1.32,
          letterSpacing: 0,
        ),
        bodyLarge: TextStyle(height: 1.48, letterSpacing: 0),
        bodyMedium: TextStyle(height: 1.46, letterSpacing: 0),
        bodySmall: TextStyle(height: 1.42, letterSpacing: 0),
      ),
    );
  }
}
