/**
 * 參考文件
 * Stopwatch
 *  https://api.flutter.dev/flutter/dart-core/Stopwatch-class.html
 * 
 */
import 'dart:io';

void main() async {
  /*
  時間知識
  elapsed -> 消逝的
  Millisecond -> 毫秒；1 秒 = 1,000 毫秒
  Microsecond -> 微秒；1 秒 = 1,000,000 微秒
  Tick -> 1 tick = 10,000,000 秒
  */
  // 建立碼表物件
  final stopwatch = Stopwatch();

  // 印出此碼表當前的消逝時間(以毫秒計)
  print(stopwatch.elapsedMilliseconds); // 0

  // 印出當前碼表的運行狀態
  print("當前是否運行：${stopwatch.isRunning}"); // false

  // 碼表啟動
  stopwatch.start();

  // 印出當前碼表的運行狀態
  print("當前是否運行：${stopwatch.isRunning}"); // true

  // 停頓 1 秒鐘
  sleep(Duration(seconds: 1));

  // 再次印出此碼表的消逝時間(以毫秒計)
  print(stopwatch.elapsedMilliseconds);

  // 再次印出此碼表的消逝時間(以微秒計)
  print(stopwatch.elapsedMicroseconds);

  // 再次印出此碼表的消逝時間(以 Tick 計)
  print(stopwatch.elapsedTicks);

  // 碼表暫停
  stopwatch.stop();

  // 印出當前碼表的運行狀態
  print("當前是否運行：${stopwatch.isRunning}"); // false

  // 將碼表的消逝時間轉換成 Duration
  Duration elapsed = stopwatch.elapsed;

  // 透過異步來延遲 1 秒
  await Future.delayed(const Duration(seconds: 1));

  // 再次印出此碼表的消逝時間(以毫秒計)
  print(stopwatch.elapsedMilliseconds);

  // 驗證是否消逝的時間相同；assert 若相同則不會報錯；反之，則會報錯
  assert(stopwatch.elapsed == elapsed); // No measured time elapsed.

  // 再次啟動
  stopwatch.start(); // Continue measuring.

  // 再次印出此碼表的消逝時間(以 Tick 計)
  print(stopwatch.elapsedTicks);

  // 再次停止碼表
  stopwatch.stop();

  // 再次印出此碼表的消逝時間(以 Tick 計)
  print(stopwatch.elapsedTicks); // Likely > 0.

  // 重置碼表
  stopwatch.reset();

  // 印出重置碼表的運行狀態
  print("重置碼表後是否運行：${stopwatch.isRunning}"); // false

  // 再次印出此碼表的消逝時間(以毫秒計)
  print(stopwatch.elapsedMilliseconds); // 0
}
