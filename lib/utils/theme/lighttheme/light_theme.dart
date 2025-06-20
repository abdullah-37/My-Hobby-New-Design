import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  fontFamily: 'Poppins',
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
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(backgroundColor: Colors.white),
  iconTheme: const IconThemeData(color: Colors.white),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
  ),
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      // Heading (H1)
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      // Title (H2)
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      // Body Title / Section title
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      // Primary Body
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      // Body Subtitle
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      // Button Text / Callouts
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,

    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.grey.shade400),
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
  bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
);
