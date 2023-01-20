import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../main.dart';

/// 呈現照相機預覽的 widget，是一個 Stateful 的組件
class CameraView extends StatefulWidget {
  // 建構子
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

/// * 相機預覽的狀態
///
/// * 邏輯
/// 1. 透過 CameraController 我們可以對相機設備做操作
/// 2. 定義最初剛開啟相機的狀態及關掉時的處理
/// 3. 相機在啟用時，會啟動圖像串流
/// 4. 圖像串流需傳入 inputImage，其包含 圖像位元組 & 圖像的 metadata
/// 5.
class _CameraViewState extends State<CameraView> {
  // CameraController，用來控制相機設備
  CameraController? _cameraController;
  // 此相機設備的相機描述索引
  int _cameraIndex = 0;
  // 鏡頭的縮放程度
  // double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;

  // 是否可以傳入新圖片辨識，若為 true 即可傳入 processImage() 進行辨識；當關閉應用(dispose) 後會轉為 false
  bool _canProcess = true;
  // 當前的辨識狀態，若為 true，則代表辨別中，此時不要傳入，不然會造成圖片一直傳入 AI辨識函數，導致應用無法負荷
  bool _isBusy = false;
  // 辨識出來的結果文字
  String _recognizedText = '';

  // 初始化，剛進到此頁面所執行的
  @override
  void initState() {
    super.initState();

    // 定義選哪一個 _cameraIndex，取決於相機的鏡頭方向 & 相機的擺放角度
    if (cameras.any(
      (element) =>
          element.lensDirection == CameraLensDirection.back &&
          element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
            element.lensDirection == CameraLensDirection.back &&
            element.sensorOrientation == 90),
      );
    } else {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back,
        ),
      );
    }
    // 初始化時，需開啟相機源
    _startLiveFeed();
  }

  // 繼承狀態關閉所執行
  @override
  void dispose() {
    _stopLiveFeed();
    _canProcess = false;
    super.dispose();
  }

  // 回傳 widget 內容
  @override
  Widget build(BuildContext context) {
    // 若 CameraController 沒有初始化
    if (!_cameraController!.value.isInitialized) {
      // 回傳空的 Container
      return Container();
    }

    return Column(children: [
      Expanded(
          flex: 3,
          child: Container(
              // 擺中間
              alignment: Alignment.center,
              color: Colors.black87,
              // 相機預覽畫面
              child: CameraPreview(_cameraController!))),
      // Expanded(
      //   flex: 1,
      //   child: Container(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Center(child: Text(_recognizedText))),
      // )
    ]);
  }

  /// 開啟相機源
  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    // 透過 此手機的相機描述 的列表，創建 CameraController
    // 因第一次的畫面啟用，解析度調成最高
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      // 關閉錄音
      enableAudio: false,
    );
    // 初始化 CameraController，透過 CameraController 與裝置的 Camera 進行溝通並且控制相機
    // 若沒有初始化，則無法使用相機預覽與拍照
    _cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      // // 取得最小縮放程度
      // _cameraController?.getMinZoomLevel().then((value) {
      //   zoomLevel = value;
      //   minZoomLevel = value;
      // });
      // // 取得最大縮放程度
      // _cameraController?.getMaxZoomLevel().then((value) {
      //   maxZoomLevel = value;
      // });
      // 啟動圖像串流，參數為串流時用來處理圖片的函數
      _cameraController?.startImageStream(_processCameraImage);

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

  /// 關閉相機源
  Future _stopLiveFeed() async {
    // 關閉圖像串流
    await _cameraController?.stopImageStream();
    await _cameraController?.dispose();
    _cameraController = null;
  }

  /// 開啟圖像串流後，接收傳遞的照相機圖像
  /// 用來初步處理此幀相片、獲取此幀相片的資訊等等
  /// 依照 AI 處理的方式
  Future _processCameraImage(CameraImage image) async {
    // 定義唯寫位元資料緩衝
    final WriteBuffer allBytes = WriteBuffer();
    // 將圖像平面一一放入位元資料緩衝
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    // 定義緩衝區資料的類型
    final bytes = allBytes.done().buffer.asUint8List();

    // 定義圖像的大小 寬、高
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    // 再次確認當下的照相機設備特性
    final camera = cameras[_cameraIndex];

    // 添加對照片的處理
    // ...

    // 將處理的照片資訊傳入 processImage 進行 AI 辨識
    // 並在內部定義處理的狀態
    // processImage(
    //   // 放入處理過後此幀的圖片與其資訊
    // );
  }

  /// 處理此幀圖像並辨識出文字
  Future<void> processImage(
      // 處理的此幀圖片與此幀圖片資訊
      ) async {
    // 若應用關閉 (dispose) 則停止辨識
    if (!_canProcess) return;
    // 若 isBusy 當前為 true，代表有圖片正在辨識，則return，不辨識；反之，若為 false，則可傳入AI辨識，並把 _isBusy 標示為 true，以防止其他幀圖片繼續傳入
    if (_isBusy) return;
    _isBusy = true;

    // 請添加 AI 辨識邏輯
    // ...
    _isBusy = false;

    // App 如果保持在手機頁面，則為 mount 狀態，可 setState
    if (mounted) {
      setState(() {});
    }
  }
}
