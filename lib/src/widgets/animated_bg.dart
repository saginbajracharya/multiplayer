import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:multiplayer/src/common/constant.dart';
import 'package:multiplayer/src/common/styles.dart';

class AnimatedBg extends StatefulWidget {
  const AnimatedBg({super.key,required this.child});

  final Widget child;
  
  @override
  State<AnimatedBg> createState() => _AnimatedBgState();
}

class _AnimatedBgState extends State<AnimatedBg> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            image : Image.asset('assets/images/Star.png'),
            baseColor : white,
            spawnMinRadius : 1.0,
            spawnMaxRadius : 10.0,
            spawnMinSpeed : 8.0,
            spawnMaxSpeed : 20.0,
            spawnOpacity : 0.5,
            minOpacity : 0.1,
            maxOpacity : 0.8,
            opacityChangeRate : 0.25,
            particleCount : 50,
          )
        ),
        vsync: this,
        child: widget.child
      ),
    );
  }
}

// RandomParticleBehaviour
// RectanglesBehaviour
// RacingLinesBehaviour

class BackgroundScaffold extends StatefulWidget {
  const BackgroundScaffold({super.key, required this.child,this.appbar, this.padding});

  final Widget child;
  final PreferredSizeWidget? appbar; 
  final EdgeInsets? padding;

  @override
  State<BackgroundScaffold> createState() => _BackgroundScaffoldState();
}

class _BackgroundScaffoldState extends State<BackgroundScaffold> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: widget.appbar,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetImages.backgroundImage),
            fit: BoxFit.cover, // Optional: You can set the fit as needed
          ),
        ),
        child: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: const ParticleOptions(
              baseColor : gold,
              spawnMinRadius : 1.0,
              spawnMaxRadius : 2.0,
              spawnMinSpeed : 8.0,
              spawnMaxSpeed : 20.0,
              spawnOpacity : 0.5,
              minOpacity : 0.1,
              maxOpacity : 1,
              opacityChangeRate : 0.25,
              particleCount : 30,
            )
          ),
          vsync: this,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust the sigmaX and sigmaY values as needed
            child: Container(
              color: black.withOpacity(0.5), // Adjust the opacity as needed
              padding: widget.padding??EdgeInsets.only(
                left: defaultPagePadding,
                right: defaultPagePadding,
                bottom: defaultPagePadding,
                top: kToolbarHeight
              ),
              child: widget.child,
            ),
          ),
        ),
      )
    );
  }
}