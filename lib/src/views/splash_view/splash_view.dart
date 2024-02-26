import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/views/splash_view/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const routeName = '/';
  
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashController splashCon = Get.put(SplashController());
  double opacity = 0.0;
  
  @override
  void initState() {
    super.initState();

    // Start the animation
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
      });
    });

    // Navigate after a few seconds
    Future.delayed(const Duration(seconds: 3), () {
      splashCon.checkAndNavigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: false,
      body: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(seconds: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.appTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40.0, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Make the text bold
                  letterSpacing: 5,
                  wordSpacing: 5,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}