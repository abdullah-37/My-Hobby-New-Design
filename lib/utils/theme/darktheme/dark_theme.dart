import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: true,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      // Heading (H1)
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      // Title (H2)
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      // Body Title / Section title
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      // Primary Body
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      // Body Subtitle
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    ),
    labelLarge: TextStyle(
      // Button Text / Callouts
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);
