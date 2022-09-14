import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

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
  CameraController? _controller;
  // 此相機設備的相機描述索引
  int _cameraIndex = 0;
  // 鏡頭的縮放程度
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;

  InputImage? inputImage;

  // final TextRecognizer _textRecognizer = TextRecognizer();
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.chinese);
  bool _canProcess = true;
  bool _isBusy = false;
  String _text = '';

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
    _textRecognizer.close();
    super.dispose();
  }

  // 回傳 widget 內容
  @override
  Widget build(BuildContext context) {
    // 若 CameraController 沒有初始化
    if (!_controller!.value.isInitialized) {
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
              child: CameraPreview(_controller!))),
      Expanded(
        flex: 1,
        child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(_text))),
      )
    ]);
  }

  /// 開啟相機源
  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    // 透過 此手機的相機描述 的列表，創建 CameraController
    // 因第一次的畫面啟用，解析度調成最高
    _controller = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    // 初始化 CameraController，透過 CameraController 與裝置的 Camera 進行溝通並且控制相機
    // 若沒有初始化，則無法使用相機預覽與拍照
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      // 取得最小縮放程度
      _controller?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      // 取得最大縮放程度
      _controller?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      // 啟動圖像串流
      _controller?.startImageStream(_processCameraImage);

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
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  /// 開啟圖像串流後，需傳遞照相機圖像
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
    // 定義圖像的旋轉
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    // 若為空值，則直接停止不做下方的操作
    if (imageRotation == null) return;

    // 取出圖像的格式
    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw);
    // 若為空值，則直接停止不做下方的操作
    if (inputImageFormat == null) return;

    // 圖像的平面資料
    final planeData = image.planes.map((Plane plane) {
      return InputImagePlaneMetadata(
          // 平面的每個 row 的位元組
          bytesPerRow: plane.bytesPerRow,
          // 平面高度 & 寬度
          height: plane.height,
          width: plane.width);
    }).toList();

    /// 將圖像資料包成 InputImageData
    final inputImageData = InputImageData(
        size: imageSize,
        imageRotation: imageRotation,
        inputImageFormat: inputImageFormat,
        planeData: planeData);

    // 輸入資料，要用來做 ocr 的
    inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    // 同步圖像資料
    processImage(inputImage!);
  }

  /// 處理圖像並辨識出文字
  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    // setState(() {
    //   _text = '';
    // });

    /// 透過辨識器，辨識出來的字
    final recognizedText = await _textRecognizer.processImage(inputImage);
    setState(() {
      _text = recognizedText.text;
    });
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
