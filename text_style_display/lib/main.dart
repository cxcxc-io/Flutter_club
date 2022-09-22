// 參考文件：https://api.flutter.dev/flutter/painting/TextStyle-class.html
// 此程式碼未展示之性質：textBaseline、locale、inherit、fontVariations、hashCode
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // 展示 Text - TextStyle 的各個性質
          title: const Text("TextStyle Properties display"),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            // fontSize - 字體大小 28 // 後面的皆以 28 呈現
            const DefaultContainerWithCustomText(Text(
              "fontSize 28",
              style: TextStyle(fontSize: 28),
            )),
            // background
            DefaultContainerWithCustomText(Text('background',
                style: TextStyle(
                    fontSize: 28, background: Paint()..color = Colors.blue))),
            // backgroundColor
            const DefaultContainerWithCustomText(Text(
              "backgroundColor",
              style: TextStyle(fontSize: 28, backgroundColor: Colors.blue),
            )),
            // color
            const DefaultContainerWithCustomText(Text(
              "color",
              style: TextStyle(fontSize: 28, color: Colors.blue),
            )),
            // debugLabel
            const DefaultContainerWithCustomText(Text(
              "debugLabel",
              style: TextStyle(
                fontSize: 28,
                debugLabel: "debugLabel 只是一個用來描述 TextStyle 的註解",
              ),
            )),
            // decoration - TextDecoration.underline
            const DefaultContainerWithCustomText(Text(
              "TextDecoration.underline",
              style:
                  TextStyle(fontSize: 24, decoration: TextDecoration.underline),
            )),
            // decoration - TextDecoration.lineThrough
            const DefaultContainerWithCustomText(Text(
              "TextDecoration.lineThrough",
              style: TextStyle(
                  fontSize: 24, decoration: TextDecoration.lineThrough),
            )),
            // decoration - TextDecoration.overline
            const DefaultContainerWithCustomText(Text(
              "TextDecoration.overline",
              style:
                  TextStyle(fontSize: 24, decoration: TextDecoration.overline),
            )),
            // decoration - TextDecoration.none
            const DefaultContainerWithCustomText(Text(
              "TextDecoration.none",
              style: TextStyle(fontSize: 24, decoration: TextDecoration.none),
            )),
            // decoration - TextDecoration.combine
            DefaultContainerWithCustomText(Text(
              "TextDecoration.combine",
              style: TextStyle(
                  fontSize: 24,
                  decoration: TextDecoration.combine(
                      [TextDecoration.overline, TextDecoration.underline])),
            )),
            // decoration + decorationColor
            const DefaultContainerWithCustomText(Text(
              "decoration + decorationColor",
              style: TextStyle(
                  fontSize: 24,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red),
            )),
            // decoration + decorationStyle(dashed)
            const DefaultContainerWithCustomText(Text(
              "decoration\ndecorationStyle(dashed)",
              style: TextStyle(
                  fontSize: 28,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed),
            )),
            // decoration + decorationStyle(dotted)
            const DefaultContainerWithCustomText(Text(
              "decoration\ndecorationStyle(dotted)",
              style: TextStyle(
                  fontSize: 28,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted),
            )),
            // decoration + decorationStyle(double)
            const DefaultContainerWithCustomText(Text(
              "decoration\ndecorationStyle(double)",
              style: TextStyle(
                  fontSize: 26,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.double),
            )),
            // decoration + decorationStyle(solid)
            const DefaultContainerWithCustomText(Text(
              "decoration\ndecorationStyle(solid)",
              style: TextStyle(
                  fontSize: 28,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid),
            )),
            // decoration + decorationThickness
            const DefaultContainerWithCustomText(Text(
              "decoration\ndecorationThickness",
              style: TextStyle(
                  fontSize: 28,
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 3.5),
            )),
            // fontFamily 需下載字體包並安裝在 pubspec.yaml 才可使用哦 // lib/fonts/BungeeSpice-Regular.ttf
            // 範例字體包下載：https://fonts.google.com/download?family=Bungee%20Spice
            const DefaultContainerWithCustomText(Text(
              "fontFamily\nBungee Spice",
              style: TextStyle(fontSize: 28, fontFamily: "Bungee Spice"),
            )),
            // fontFamilyFallback
            // 追加字體包下載：https://fonts.google.com/download?family=Fugaz%20One
            const DefaultContainerWithCustomText(Text(
              "fontFamilyFallback",
              style: TextStyle(
                  fontSize: 28,
                  // 預設字體排序，前面的優先使用
                  fontFamilyFallback: ["FugazOne", "Bungee Spice"],
                  // 若找不到字體
                  fontFamily: "aaa"),
            )),
            // fontFeatures - 須取決於你選定的 fontFamily 是否支援
            // 因 Flutter 預設字體為 Roboto 有支援 smcp (小型大寫字母)
            const DefaultContainerWithCustomText(Text(
              "fontFeatures",
              style: TextStyle(
                  fontSize: 28, fontFeatures: [FontFeature.enable('smcp')]),
            )),
            // fontStyle - italic 斜體
            const DefaultContainerWithCustomText(Text(
              "FontStyle - italic",
              style: TextStyle(fontSize: 28, fontStyle: FontStyle.italic),
            )),
            // fontWeight - bold
            const DefaultContainerWithCustomText(Text(
              "fontWeight - bold",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            )),
            // fontWeight - w900
            const DefaultContainerWithCustomText(Text(
              "fontWeight - w900",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            )),
            // fontWeight - w100
            const DefaultContainerWithCustomText(Text(
              "fontWeight - w100",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w100,
              ),
            )),
            // foreground
            DefaultContainerWithCustomText(Text(
              "foreground",
              style: TextStyle(
                  fontSize: 28, foreground: Paint()..color = Colors.cyan),
            )),
            //
            const DefaultContainerWithCustomText(Text(
              "height - -0.5",
              style: TextStyle(fontSize: 28, height: -0.5),
            )),
            //
            const DefaultContainerWithCustomText(Text(
              "height - 2.0",
              style: TextStyle(fontSize: 28, height: 2.5),
            )),
            // leadingDistribution - even 影響文本垂直高度，當指定 height 值
            const DefaultContainerWithCustomText(Text(
              "TextLeadingDistribution\nabc even",
              style: TextStyle(
                  fontSize: 24,
                  leadingDistribution: TextLeadingDistribution.even,
                  height: 1.5),
            )),
            // leadingDistribution - proportional 影響文本垂直高度，當指定 height 值
            const DefaultContainerWithCustomText(Text(
              "TextLeadingDistribution\nabc propor",
              style: TextStyle(
                  fontSize: 24,
                  leadingDistribution: TextLeadingDistribution.proportional,
                  height: 1.5),
            )),
            // letterSpacing
            const DefaultContainerWithCustomText(Text(
              "letterSpacing -2.0",
              style: TextStyle(fontSize: 28, letterSpacing: 2.0),
            )),
            // TextOverflow不加
            const DefaultContainerWithCustomText(Text(
              "TextOverflow不加TextOverflow不加TextOverflow不加TextOverflow不加TextOverflow不加",
              style: TextStyle(fontSize: 28),
            )),
            // TextOverflow - clip
            const DefaultContainerWithCustomText(Text(
              "TextOverflow-TextOverflow-TextOverflow-TextOverflow-TextOverflow-TextOverflow",
              style: TextStyle(fontSize: 28, overflow: TextOverflow.clip),
            )),
            // TextOverflow - ellipsis
            const DefaultContainerWithCustomText(Text(
              "TextOverflow.ellipsis-TextOverflow.ellipsis-TextOverflow.ellipsis-TextOverflow.ellipsis",
              style: TextStyle(fontSize: 28, overflow: TextOverflow.ellipsis),
            )),
            // TextOverflow - fade
            const DefaultContainerWithCustomText(Text(
              "TextOverflow.fade-TextOverflow.fade-TextOverflow.fade-TextOverflow.fade",
              style: TextStyle(fontSize: 28, overflow: TextOverflow.fade),
            )),
            // TextOverflow - visible
            const DefaultContainerWithCustomText(Text(
              "TextOverflow.visible-TextOverflow.visible-TextOverflow.visible-TextOverflow.visible",
              style: TextStyle(fontSize: 28, overflow: TextOverflow.visible),
            )),
            // shadows
            const DefaultContainerWithCustomText(Text(
              "shadows",
              style: TextStyle(fontSize: 28, shadows: [
                Shadow(
                  offset: Offset(10.0, 10.0),
                  blurRadius: 5.0,
                  color: Colors.grey,
                ),
                Shadow(
                    offset: Offset(-18.0, -10.0),
                    blurRadius: 1.0,
                    color: Colors.amber),
              ]),
            )),

            // wordSpacing and 5.5
            DefaultContainerWithCustomText(Text(
              "wordSpacing and 5.5",
              style: TextStyle(fontSize: 28, wordSpacing: 5.5),
            )),

            // wordSpacing and 15.5
            DefaultContainerWithCustomText(Text(
              "wordSpacing and 15.5",
              style: TextStyle(fontSize: 28, wordSpacing: 15.5),
            )),
          ],
        ),
      ),
    );
  }
}

// 預設方框，用來擺入 Text 的
class DefaultContainerWithCustomText extends StatelessWidget {
  const DefaultContainerWithCustomText(this.customText, {Key? key})
      : super(key: key);
  final Text customText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      height: 80,
      // 將 Container 設置成方框設置
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            // 陰影設置，看起來比較立體
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 6,
                blurRadius: 6,
                offset: Offset.fromDirection(5, -5))
          ]),
      child: customText,
    );
  }
}
