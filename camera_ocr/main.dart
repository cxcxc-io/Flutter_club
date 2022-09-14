/* 
參考文件:
https://github.com/bharat-biradar/Google-Ml-Kit-plugin/tree/master/packages/google_ml_kit/example/lib/vision_detector_views
https://pub.dev/documentation/camera/latest/camera/camera-library.html
*/
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

late List<CameraDescription> cameras;

// 程式的入口
Future<void> main() async {
  // 相機的使用，會呼叫 native code，因此需透過 WidgetsBinding 呼叫實體
  WidgetsFlutterBinding.ensureInitialized();

  // 獲取 此手機的相機描述 的列表，包含前後相機
  cameras = await availableCameras();
  runApp(const CameraApp());
}

// 建立大畫板 MaterialApp
class CameraApp extends StatelessWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
