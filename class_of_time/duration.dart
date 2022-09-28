/**
 * 參考文件
 * Duration
 *  https://api.flutter.dev/flutter/dart-core/Duration-class.html
 * 
 */
import 'dart:io';

void main() async {
  // Duration - 持續時間 - 官方示例
  const fastestMarathon = Duration(hours: 2, minutes: 3, seconds: 2);
  // // 不受限於一般的 24 小時 or 60 分鐘...
  // const fastestMarathon = Duration(hours: 60, minutes: 3, seconds: 2);
  print(fastestMarathon.inDays); // 0
  print(fastestMarathon.inHours); // 2
  print(fastestMarathon.inMinutes); // 123
  print(fastestMarathon.inSeconds); // 7382
  print(fastestMarathon.inMilliseconds); // 7382000

  // 持續時間可以是負數
  const overDayAgo = Duration(days: -1, hours: -10);
  print(overDayAgo.inDays); // -1
  print(overDayAgo.inHours); // -34
  print(overDayAgo.inMinutes); // -2040

  // in開頭的屬性 會捨去末尾值，如 88 小時，相當於 3 天 16 小時，直接捨去 16 小時
  const aLongWeekend = Duration(hours: 88);
  print(aLongWeekend.inDays); // 3

  // Duration 可使用運算子進行加減
  const firstHalf = Duration(minutes: 45); // 00:45:00.000000
  const secondHalf = Duration(minutes: 45); // 00:45:00.000000
  const overTime = Duration(minutes: 30); // 00:30:00.000000
  final maxGameTime = firstHalf + secondHalf + overTime;
  print(maxGameTime.inMinutes); // 120

  // 不同參數的值進行加減
  const oneHour = Duration(days: 1); // 24*60=1440
  const thirtyMin = Duration(minutes: 30);
  final sumTime = oneHour + thirtyMin;
  print(sumTime.inMinutes); // 1470

// // 透過 compareTo 可以比較兩個 Duration，若相同，則回傳 0
  var result = firstHalf.compareTo(secondHalf);
  print(result); // 0

// // 若 小於 放入的 Duration -> overTime < firstHalf -> 回傳 -1
  result = overTime.compareTo(firstHalf);
  print(result); // < 0

// // 若 大於 放入的 Duration -> secondHalf > overTime -> 回傳 1
  result = secondHalf.compareTo(overTime);
  print(result); // > 0
}
