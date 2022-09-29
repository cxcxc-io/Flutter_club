/**
 * 參考文件
 * timer
 *  https://api.flutter.dev/flutter/dart-async/Timer-class.html
 * 
 */

import 'dart:async';
import 'dart:io';

void main() {
  /*
  Timer：
  * 可設置僅倒數一次或重複地倒數。
  * 指定一個 Duration 倒數至 0。當達到 0 時，會觸發一個回呼函數。
  * 可定義一個周期性的倒數計時器，每個周期都是同一個 Duration 區間。
  * 若 Duration 為負數或是在統計上被視為 0，則該計時器會直接運行回呼函數。
  * Duration 經常是一個常數或是一個被運算的數。
   */

  // 建立碼表物件
  final stopwatch = Stopwatch();
  // 碼表啟動
  stopwatch.start();

  // 建立函數並執行 (5 秒)
  scheduleTimeout(5 * 1000); // 5 seconds.

  // 停頓 5 秒鐘
  sleep(Duration(seconds: 5));

  // 印出此碼表的消逝時間(以毫秒計)
  print(stopwatch.elapsedMilliseconds);

  // 建立函數並執行 (3 秒)
  Timer threeSecondsTimer = scheduleTimeout(3 * 1000); // 3 seconds.

  // 查看計時器的所歷經 Duration 的次數
  print(threeSecondsTimer.tick);

  // 查看計時器運行
  print(threeSecondsTimer.isActive);

  // 取消計時器
  threeSecondsTimer.cancel();

  // 查看計時器運行
  print(threeSecondsTimer.isActive);
}

// 定義一個 函數
// https://dart.dev/guides/language/language-tour#parameters
// [] -> Wrapping a set of function parameters in [] marks them as optional positional parameters
// [] 可用來包裹 optional (可選)參數
Timer scheduleTimeout([int milliseconds = 10000]) =>
    Timer(Duration(milliseconds: milliseconds), handleTimeout);

void handleTimeout() {
  // callback function
  // Do some work.
  // Execute this callback ASAP but asynchronously // 會異步處理 因此一定會比 void main 主程式慢
  print("秒數到了哦");
}
