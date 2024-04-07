import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
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
  const BackgroundScaffold({super.key, required this.child,this.appbar});

  final Widget child;
  final PreferredSizeWidget? appbar; 

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
      appBar: widget.appbar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
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
              child: widget.child,
            ),
          ),
        ),
      )
    );
  }
}