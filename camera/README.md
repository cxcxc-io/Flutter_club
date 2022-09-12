# Flutter camera 套件

## 使用方法
直接建一個新的專案，依照下面的步驟執行

## IOS 版本需 iOS 10 以上，若要使用 camera，需添加兩行至 ios/Runner/Info.plist：
```
<key>NSCameraUsageDescription</key>
<string>your usage description here</string>
<key>NSMicrophoneUsageDescription</key>
<string>your usage description here</string>
```

## Android sdk version 版本需大於等於 21，並且於 android/app/build.gradle 檔案紀錄：
```
minSdkVersion 21
```

## 注意事項
1. MediaRecorder Class 無法在模擬器上運作。

## 實作流程
1. 添加 camera 套件至 pubspec.yaml
```
dependencies:
    camera: ^0.10.0+1
```

2. 更新 Android sdk version 為 minSdkVersion 21
開啟 android/app/build.gradle，找到 minSdkVersion 的部分，更新成 minSdkVersion 21

3. 貼上官方範例程式碼，進行測試
lib/main.dart

4. 連接自己的手機，測試成果

## 程式碼概略解析流程
1. 透過 WidgetsFlutterBinding 進行底層 code 聯繫
2. 獲取 Camera 描述清單
3. 建立主頁面 與 State
4. 透過 Camera 描述清單，建立 CameraController
5. CameraController 初始化
6. 附加查看掛載狀態
7. 若有錯誤，印出錯誤
8. CameraController 繼承 dispose 函數
9. 回傳主頁面呈現渲染

## 參考文件
https://pub.dev/packages/camera
