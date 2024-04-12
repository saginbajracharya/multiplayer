import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';

class Level1 extends StatefulWidget {
  const Level1({Key? key}) : super(key: key);

  static const routeName = '/level_1';

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  final HomeController homeCon = Get.put(HomeController());
  double player1X = 250;
  double player1Y = 255;
  double player2X = 25;
  double player2Y = 25;
  int coins = 0;
  int gems = 0;
  bool paused = false;
  bool gameOver = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!paused && !gameOver) {
        // Update player 2 position to follow player 1
        if (player2X < player1X) {
          player2X += 1;
        } else {
          player2X -= 1;
        }
        if (player2Y < player1Y) {
          player2Y += 1;
        } else {
          player2Y -= 1;
        }

        // Check if player 2 caught player 1
        if ((player1X - player2X).abs() < 50 && (player1Y - player2Y).abs() < 50) {
          setState(() {
            gameOver = true;
          });
          timer.cancel();
        }

        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (!paused && !gameOver) {
            setState(() {
              player1X += details.delta.dx;
              player1Y += details.delta.dy;
            });
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Game background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                ),
              ),
            ),
            // Player 1
            Positioned(
              left: player1X,
              top: player1Y,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'Player 1',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            // Player 2 (enemy)
            Positioned(
              left: player2X,
              top: player2Y,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'Enemy',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            // Coins
            Positioned(
              top: 40,
              right: 16,
              child: Row(
                children: [
                  SvgPicture.asset(
                    width: 20,
                    height: 20,
                    'assets/images/coin.svg',
                  ),
                  const SizedBox(width: 4),
                  Obx(()=>
                    Text(
                      homeCon.userTotalCoin.value!=""
                      ?homeCon.userTotalCoin.value
                      :'0',
                      style: normalTextStyleBlack
                    ),
                  )
                ],
              ),
            ),
            // Gems
            Positioned(
              top: 40,
              left: 16,
              child: Row(
                children: [
                  SvgPicture.asset(
                    width: 20,
                    height: 20,
                    'assets/images/gem.svg',
                  ),
                  const SizedBox(width: 4),
                  Obx(()=>
                    Text(
                      homeCon.userTotalGem.value!=""
                      ?homeCon.userTotalGem.value
                      :'0',
                      style: normalTextStyleBlack
                    ),
                  )
                ],
              ),
            ),
            // Pause button
            Positioned(
              top: 40,
              right: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    paused = !paused;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.pause,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Pause overlay
            if (paused && !gameOver)
              Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Paused',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            paused = false;
                          });
                        },
                        child: const Text('Resume'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Exit'),
                      ),
                    ],
                  ),
                ),
              ),
            // Game over screen
            if (gameOver && !paused)
              Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Game Over',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            gameOver = false;
                            player1X = 250;
                            player1Y = 255;
                            player2X = 25;
                            player2Y = 25;
                          });
                          timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
                            if (!paused && !gameOver) {
                              if (player2X < player1X) {
                                player2X += 1;
                              } else {
                                player2X -= 1;
                              }
                              if (player2Y < player1Y) {
                                player2Y += 1;
                              } else {
                                player2Y -= 1;
                              }

                              if ((player1X - player2X).abs() < 50 && (player1Y - player2Y).abs() < 50) {
                                setState(() {
                                  gameOver = true;
                                });
                                timer.cancel();
                              }

                              setState(() {});
                            }
                          });
                        },
                        child: const Text('Retry'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Exit'),
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
