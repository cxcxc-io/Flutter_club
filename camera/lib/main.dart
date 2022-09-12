import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  // 相機的使用，會呼叫 native code，因此需透過 WidgetsBinding 呼叫實體
  WidgetsFlutterBinding.ensureInitialized();

  // 獲取 此手機的相機描述 的列表，包含前後相機
  _cameras = await availableCameras();
  runApp(const CameraApp());
}

/// CameraApp is the Main Application.
/// 動態 Widget
class CameraApp extends StatefulWidget {
  /// Default Constructor 建構子
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  // 初始化，剛進到此頁面所執行的
  @override
  void initState() {
    super.initState();
    // 透過 此手機的相機描述 的列表，創建 CameraController
    // 因第一次的畫面啟用，所以將預設索引設定為 0，解析度調成最高
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    // 初始化 CameraController，透過 CameraController 與裝置的 Camera 進行溝通並且控制相機
    // 若沒有初始化，則無法使用相機預覽與拍照
    controller.initialize().then((_) {
      // https://api.flutter.dev/flutter/widgets/State/mounted.html
      // 相機須掛載，透過 mounted 可以檢查目前的掛載狀態
      // 若 _CameraAppState dispose，則非掛載狀態或已被關閉，狀態即不再更新
      // 若 mounted 仍為掛載狀態，則可繼續更新狀態
      // https://stackoverflow.com/questions/65234864/flutter-dart-what-is-mounted-for
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  // 繼承狀態關閉所執行
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 若 CameraController 沒有初始化
    if (!controller.value.isInitialized) {
      // 回傳空的 Container
      return Container();
    }
    return MaterialApp(
      // 相機預覽頁面
      home: CameraPreview(controller),
    );
  }
}
