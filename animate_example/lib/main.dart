import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 創建布林值以使用動畫
  bool isalign = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(30),
          height: 400,
          width: double.infinity,
          color: Colors.blue,
          // 建立動畫 widget AnimatedAlign，用來操縱 widget 從 A 點到 B 點
          child: AnimatedAlign(
            // 定義動畫執行的時間
            duration: const Duration(seconds: 1),
            // 定義不同種類的曲線路徑
            curve: Curves.ease,
            // 定義動畫的布林值，當 true 為 A 處；false 則為 B 處
            alignment: isalign ? Alignment.topRight : Alignment.bottomLeft,
            // 動畫移動的物件，以圓形頭像作為移動範例物件
            child: const CircleAvatar(
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 點擊此浮動按鈕後，改變 isalign 布林值的值
          setState(() {
            isalign = !isalign;
          });
        },
        // 按鈕的圖片
        child: const Icon(Icons.play_circle),
      ),
    );
  }
}
