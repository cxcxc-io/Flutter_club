# get_frames_then_ai_recognize_from_camera_example

此範例應用 啟動後開啟相機
相機會記錄下每一幀的圖像

根據要做的 圖像處理 與 AI處理邏輯
分別放入 lib/components/camera_view.dart
內部的 _processCameraImage(每幀照片與其資訊的處理的函數) 與 processImage(處理後的該幀照片做 AI 辨識的函數)

## 使用前
【iOS】
在 ios/Runner/Info.plist
添加
```
<!-- ↓ 相機 ↓-->
<key>NSCameraUsageDescription</key>
<string>your usage description here</string>
<key>NSMicrophoneUsageDescription</key>
<string>your usage description here</string>
<!-- ↑ 相機 ↑-->
```

【Android】
並在 android/app/build.gradle
將
```
minSdkVersion flutter.minSdkVersion
```
換成
```
minSdkVersion 21
```

