import 'package:example_code/home_screen.dart';
import 'package:flutter/material.dart';

import './splash_screen.dart';
import './home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Splash Demo',
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      home: SplashScreen(),
      routes: {
        "/home": (BuildContext context) => const HomeScreen(),
      },
    );
  }
}
