import 'package:flutter/material.dart';

import '../components/camera_view.dart';

/// HomeScreen is the Main Application.
/// 動態 Widget
class HomeScreen extends StatefulWidget {
  /// Default Constructor 建構子
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 初始化，剛進到此頁面所執行的
  @override
  void initState() {
    super.initState();
  }

  // 繼承狀態關閉所執行
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 首頁呈現
    return Scaffold(
        appBar: AppBar(
          title: const Text("AI辨識每幀圖片"),
          centerTitle: true,
        ),
        body: const CameraView());
  }
}
