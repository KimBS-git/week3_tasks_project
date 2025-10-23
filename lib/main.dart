import 'package:flutter/material.dart';
import 'package:week3_project/home/home_page.dart';
import 'package:week3_project/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,

    home: HomePage(),
    

    );
  }
}

