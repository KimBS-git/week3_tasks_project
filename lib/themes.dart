import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  dividerColor: Colors.white60,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black,
  brightness: Brightness.light),
  scaffoldBackgroundColor: Colors.grey[400],
  appBarTheme: AppBarTheme(
  foregroundColor: Colors.black,
    backgroundColor: Colors.grey[300],
  ),
);
final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black,
  brightness: Brightness.dark),
  dividerColor: Colors.white30,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    foregroundColor: Colors.white,
    backgroundColor: Colors.grey[900],
  ),   
  );