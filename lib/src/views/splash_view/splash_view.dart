import 'package:flutter/material.dart';
import 'package:get/get.dart';
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