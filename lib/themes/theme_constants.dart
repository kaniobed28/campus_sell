import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFC4C4C4),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Color( 0xFF132FBA)),
    headlineSmall: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 14,color: Color( 0xFFC4C4C4)),
    bodyMedium: TextStyle(fontSize: 14,color: Color( 0xFFEEEEEE),), // this is the theme responsible for the app text by default. the default font size for the app is 14
    bodySmall: TextStyle(fontSize: 16,color: Color( 0xFFC4C4C4)),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color( 0xFFEEEEEE),),
    
  ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: const Color(0xFF799CF0),
  //     textStyle: const TextStyle(
  //       color: Color(0xFFEEEEEE),
  //     ),
  //   ),
  // ),

  // scaffoldBackgroundColor: Colors.grey.shade200
);
