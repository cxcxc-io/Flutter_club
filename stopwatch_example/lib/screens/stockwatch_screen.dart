import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';

/// 碼表的頁面
class StockwatchScreen extends StatefulWidget {
  // 建構子
  const StockwatchScreen({Key? key}) : super(key: key);

  @override
  State<StockwatchScreen> createState() => _StockwatchScreenState();
}

class _StockwatchScreenState extends State<StockwatchScreen> {
  // 建立碼表物件
  final stopwatch = Stopwatch();
  // 建立分、秒與秒的後兩位，預設為 0
  int min = 0;
  int seconds = 0;
  int doubleOfSeconds = 0;
  bool startOrNot = false;
  Timer? timer;

  /// 初始狀態，剛進頁面的狀態
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stopwatch.reset();
  }

  /// 啟動週期計時器，並放入回呼函數 addTime。每當一個周期到了，就會運行加時間的回呼函數
  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 10), (_) => addTime());
  }

  /// 當點擊重設時，會使用的函數，即所有時間歸 0
  void reset() {
    setState(() {
      min = 0;
      seconds = 0;
      doubleOfSeconds = 0;
    });
  }

  /// 每個 tick 觸發的回呼函數
  void addTime() {
    setState(() {
      // 定義當前的 Duration 消逝的時間 (單位:毫秒)
      int milliSeconds = stopwatch.elapsed.inMilliseconds;
      // 秒數小數點後兩位 = 總消逝的時間 - (總消逝時間 / 100 後，再乘以 100。即去除掉 milliSeconds 的後兩位數)
      doubleOfSeconds = (milliSeconds - (milliSeconds ~/ 100) * 100);
      // 秒 = 總消逝時間/1000 - 分 * 60(秒) 並轉換成整數去除小數後方
      seconds = (milliSeconds / 1000 - min * 60).toInt();
      // 分 = 總消逝時間以分鐘的形式
      min = stopwatch.elapsed.inMinutes;
// Ex. 60000
// Ex. 5443-54*100=43
      // final secondsTime = seconds + 0.01;
      if (doubleOfSeconds < 0) {
        timer?.cancel();
      }
      // else {
      //   seconds = secondsTime;
      // }
    });
  }

  /// 停止計時器
  void stopTimer() {
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    // 為了讓數字維持至少 2 位數，使用 padLeft
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    // 首頁呈現
    return Scaffold(
        appBar: AppBar(
          title: const Text("Stockwatch 練習"),
          centerTitle: true,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
          child: Column(
            children: [
              // 時間字卡
              Expanded(
                flex: 4,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  // 分鐘
                  buildTimeCard(time: twoDigits(min), header: 'MINS'),
                  const SizedBox(
                    width: 8,
                    child: Text(
                      ":",
                      style: TextStyle(
                          fontSize: 30,
                          height: -0.5,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  // 秒數
                  buildTimeCard(time: twoDigits(seconds), header: 'SECONDS'),
                  const SizedBox(
                    width: 8,
                    child: Text(
                      ".",
                      style: TextStyle(
                          fontSize: 30,
                          height: -0.1,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  // 秒數小數點後 2 位
                  buildTimeCard(time: twoDigits(doubleOfSeconds), header: ''),
                ]),
              ),
              // 重設按鍵
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              // 陰影設置，看起來比較立體
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 6,
                                  blurRadius: 6,
                                  offset: Offset.fromDirection(5, -5))
                            ]),
                        child: TextButton(
                          child: Text(
                            "重設",
                            style: TextStyle(
                                fontSize: 24,
                                height: 1.2,
                                color: Colors.grey[600]),
                          ),
                          onPressed: () {
                            setState(() {
                              reset();
                              // 碼表暫停並重設
                              stopwatch.stop();
                              stopwatch.reset();
                              // 停止計時器
                              stopTimer();
                              // 碼表運行狀態設為 false
                              startOrNot = false;
                            });
                          },
                        )),
                    Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              // 陰影設置，看起來比較立體
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 6,
                                  blurRadius: 6,
                                  offset: Offset.fromDirection(5, -5))
                            ]),
                        child: TextButton(
                          child: Text(
                            // 判斷當前碼表的狀態，若為 true (運行中)，顯示暫停按鍵；反之，則顯示開始
                            startOrNot == true ? "暫停" : "開始",
                            style: TextStyle(
                                fontSize: 24,
                                height: 1.2,
                                color: Colors.grey[600]),
                          ),
                          // 點擊之後，觸發的函數
                          onPressed: () {
                            setState(() {
                              if (startOrNot == true) {
                                // 點擊後，需暫停
                                stopwatch.stop();
                                stopTimer();
                                startOrNot = false;
                              } else {
                                // 點擊後，需開始
                                stopwatch.start();
                                startTimer();
                                startOrNot = true;
                              }
                            });
                          },
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  // 建立碼表的時間字卡
  Widget buildTimeCard({required String time, required String header}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 50),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(header, style: const TextStyle(color: Colors.black45)),
      ],
    );
  }
}
