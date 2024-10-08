import 'package:flutter/material.dart';

// Light Theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFF5F5F5), // Primary color
  scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Background color

  // Light Color Scheme
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF132FBA), // Primary color for light theme
    secondary: Color(0xFF799CF0), // Accent color
    surface: Color(0xFFFFFFFF), // Card color or surfaces
    error: Color(0xFFF44336), // Error color
    onPrimary: Color(0xFFFFFFFF), // Text color on primary color
    onSecondary: Color(0xFF000000), // Text color on secondary color
    onSurface: Color(0xFF000000), // Text color on surfaces
    onError: Color(0xFFFFFFFF), // Text on error color
  ),

  // Text theme
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(
        fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF132FBA)),
    headlineSmall: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 14, color: Color.fromARGB(255, 7, 7, 7)),
    bodyMedium: TextStyle(fontSize: 14, color: Color.fromARGB(255, 1, 1, 1)),
    bodySmall: TextStyle(fontSize: 16, color: Color.fromARGB(255, 4, 4, 4)),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),

  // Button themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF799CF0), // Button background color
      foregroundColor: const Color(0xFFEEEEEE), // Button text color
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // Divider theme
  dividerTheme: const DividerThemeData(
    color: Color(0xFFBDBDBD), // Divider color
    thickness: 1.0,
  ),

  // Floating action button theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF132FBA), // FAB background color
    foregroundColor: Colors.white, // FAB icon/text color
  ),

  // Checkbox theme
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(const Color(0xFF132FBA)), // Check color
  ),
);

// Dark Theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF151513), // Dark primary color
  scaffoldBackgroundColor: const Color(0xFF121212), // Dark background color

  // Dark Color Scheme
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF1E88E5), // Primary color for dark theme
    secondary: Color(0xFFBB86FC), // Accent color
    surface: Color(0xFF333333), // Surface color for cards and dialogs
    error: Color(0xFFCF6679), // Error color
    onPrimary: Color(0xFF000000), // Text color on primary
    onSecondary: Color(0xFFFFFFFF), // Text color on secondary
    onSurface: Color(0xFFFFFFFF), // Text color on surfaces
    onError: Color(0xFFFFFFFF), // Text on error color
  ),

  // Text theme
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    headlineLarge: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF1E88E5)),
    headlineSmall: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 14, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFEEEEEE)),
    bodySmall: TextStyle(fontSize: 16, color: Colors.white),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
    labelMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
    labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
  ),

  // Button themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1E88E5), // Button background color for dark theme
      foregroundColor: const Color(0xFFFFFFFF), // Button text color for dark theme
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // Divider theme
  dividerTheme: const DividerThemeData(
    color: Color(0xFFBDBDBD), // Divider color for dark theme
    thickness: 1.0,
  ),

  // Floating action button theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF1E88E5), // FAB background color
    foregroundColor: Colors.white, // FAB icon/text color
  ),

  // Checkbox theme
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.all(const Color(0xFF1E88E5)), // Check color
  ),
);
