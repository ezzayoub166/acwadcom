// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Color(0xFF122738),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Color(0xFF122738), // Primary color
    secondary: Color(0xFFF4A300), // Accent color
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.cairo(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.cairo(
      color: Color(0xFFD3D3D3),
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: GoogleFonts.cairo(
      color: Color(0xFFD3D3D3),
      fontSize: 16,
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: GoogleFonts.cairo(
      color: Color(0xFFD3D3D3),
      fontSize: 18,
      fontWeight: FontWeight.w800,
    ),
    bodyLarge: GoogleFonts.cairo(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.cairo(
      color: Color(0xFFD3D3D3),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: GoogleFonts.cairo(
      color: Color(0xFFD3D3D3),
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: IconThemeData(
    color: Color(0xFF6C8C94),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: GoogleFonts.cairo(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
     style: OutlinedButton.styleFrom(
      textStyle: GoogleFonts.cairo(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        // color: Colors.white
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
    ),

  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFFF4A300),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: GoogleFonts.cairo(
      // Use GoogleFonts.cairo for hint text
      color: Colors.grey,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Colors.blue, // Customize border color for focus state
        width: 1,
      ),
    ),
  ),
);
