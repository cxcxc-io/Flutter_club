import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // video 控制器
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.asset("assets/water_splash_stock_video.mp4")
          ..initialize().then((_) {
            setState(() {});
          })
          // 音量調成0
          ..setVolume(0.0);

    _playVideo();
  }

  void _playVideo() async {
    // 播放影片
    _controller.play();

    // 添加延遲直到影片被編譯
    await Future.delayed(const Duration(seconds: 7));

    // 切換到主頁面
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              )
            : Container(),
      ),
    );
  }
}
