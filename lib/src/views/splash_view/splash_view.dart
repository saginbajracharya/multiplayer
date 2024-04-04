import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/audio_manager.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';
import 'package:multiplayer/src/views/splash_view/splash_controller.dart';
import 'package:multiplayer/src/widgets/logo_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const routeName = '/';
  
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashController splashCon = Get.put(SplashController());
  
  @override
  void initState() {
    super.initState();
    // splashCon.checkInitialConnectivity();
    dynamic audioOn = read(StorageKeys.audioOnKey)==""?true:read(StorageKeys.audioOnKey);
    if(audioOn){
      AudioManager().play('assets/audio/theme_song.mp3');
    }

    // Navigate after a few seconds
    Future.delayed(const Duration(seconds: 3), () {
      splashCon.checkAndNavigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: false,
      body: Center(
        child: LogoWidget()
      )
    );
  }
}