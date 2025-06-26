import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  fontFamily: 'Poppins',
  //
  // primaryColor: Colors.deepPurple.shade300,
  // colorScheme: ColorScheme.light(
  //   primary: Colors.deepPurple.shade300,
  //   secondary: Colors.black.withValues(alpha: 0.1), // 👈 Your secondary color
  // ),
  // puplr scheme
  primaryColor: Colors.deepPurple,
  colorScheme: ColorScheme.light(
    primary: Colors.deepPurple.shade300,
    secondary: Colors.purple, // 👈 Your secondary color
  ),

  scaffoldBackgroundColor: Color(0xFF141a1f),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xFF141a1f)),
  iconTheme: const IconThemeData(color: Color(0xFF141a1f)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF141a1f),
  ),

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
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      // Body Title / Section title
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      // Primary Body
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      // Body Subtitle
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
    bodySmall: TextStyle(
      // Body Subtitle
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      // Button Text / Callouts
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey.withValues(alpha: 0.2),
    filled: true,

    hintStyle: TextStyle(color: Colors.white),
    labelStyle: TextStyle(color: Colors.white),
    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.white),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.red, width: 2.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.red, width: 2.0),
    ),
  ),
);
