/**
 * 參考文件
 * timer.periodic
 *  https://api.flutter.dev/flutter/dart-async/Timer/Timer.periodic.html
 * 
 */

import 'dart:async';

void main() {
  /*
  Timer.periodic：
  * 即創建一新的重複計時的計時器。

  * 直到使用 cancel 函數取消計時器，否則週期計時器會一直在指定的 Duration 區間不斷 repeat。

  * 盡可能精準，但每個周期或多或少有誤差，取決於底層計時器的執行。特別是，當每個周期的 Duration 可能互相調度。

  * Duration 不能是負值。 
   */
  // 計數用
  var counter = 3;
  print("測試開始");
  // 建立週期計時器，2 秒為 1 tick
  Timer.periodic(const Duration(seconds: 2), (timer) {
    // 印出計時器的所歷經 Duration 的次數
    print(timer.tick);

    // 減少計數
    counter--;

    // 當計數減為 0
    if (counter == 0) {
      print('Cancel timer');

      // 取消計時器
      timer.cancel();
    }
  });
  print("測試結束");

  // Outputs:
  // 測試開始
  // 測試結束
  // 1
  // 2
  // 3
  // "Cancel timer"
}
