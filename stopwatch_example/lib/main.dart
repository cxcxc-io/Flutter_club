/**
 * 此專案將練習如何建立一個碼表頁面，可以點擊開始、暫停及重設
 * 
 * 參考文件
 *  https://medium.flutterdevs.com/stopwatch-timer-in-flutter-70afa58d88e5
 */

import 'package:flutter/material.dart';

import 'screens/stockwatch_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stockwatch Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StockwatchScreen(),
    );
  }
}
