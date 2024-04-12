import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';

class Enemy {
  double x;
  double y;

  Enemy(this.x, this.y);
}

class Level extends StatefulWidget {
  const Level({Key? key}) : super(key: key);

  static const routeName = '/level';

  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  final HomeController homeCon = Get.put(HomeController());
  double player1X = 250;
  double player1Y = 255;
  List<Enemy> enemies = [];
  bool paused = false;
  bool gameOver = false;
  late Timer timer;
  late Timer enemySpawnTimer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!paused && !gameOver) {
        setState(() {
          // Update enemy positions to follow player
          for (var enemy in enemies) {
            if (enemy.x < player1X) {
              enemy.x += 1;
            } else {
              enemy.x -= 1;
            }
            if (enemy.y < player1Y) {
              enemy.y += 1;
            } else {
              enemy.y -= 1;
            }

            // Check if an enemy caught the player
            if ((player1X - enemy.x).abs() < 50 && (player1Y - enemy.y).abs() < 50) {
              gameOver = true;
              timer.cancel();
              enemySpawnTimer.cancel();
            }
          }
        });
      }
    });

    // Spawn enemies every 5 seconds
    enemySpawnTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        // Spawn a new enemy
        enemies.add(Enemy(25, 25));
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    enemySpawnTimer.cancel();
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
            // Enemies
            ...enemies.map((enemy) => Positioned(
                  left: enemy.x,
                  top: enemy.y,
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
                )).toList(),
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
                            enemies.clear();
                          });
                          timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
                            if (!paused && !gameOver) {
                              setState(() {
                                for (var enemy in enemies) {
                                  if (enemy.x < player1X) {
                                    enemy.x += 1;
                                  } else {
                                    enemy.x -= 1;
                                  }
                                  if (enemy.y < player1Y) {
                                    enemy.y += 1;
                                  } else {
                                    enemy.y -= 1;
                                  }

                                  if ((player1X - enemy.x).abs() < 50 &&
                                      (player1Y - enemy.y).abs() < 50) {
                                    gameOver = true;
                                    timer.cancel();
                                    enemySpawnTimer.cancel();
                                  }
                                }
                              });
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
