import 'package:flutter/material.dart';
import 'package:yurimovieapp/screens/homeScreen.dart';

void main() {
  runApp(const YurisMovieApp());
}

class YurisMovieApp extends StatelessWidget {
  const YurisMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomeScreen(),
    );
  }
}
