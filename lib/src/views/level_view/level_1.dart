import 'package:flutter/material.dart';
import 'package:multiplayer/src/common/styles.dart';

class Level1 extends StatefulWidget {
  const Level1({Key? key}) : super(key: key);

  static const routeName = '/level_1';

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {

  double player1X = 250;
  double player1Y = 255;
  double player2X = 25;
  double player2Y = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            player1X += details.delta.dx;
            player1Y += details.delta.dy;
          });
        },
        child: Stack(
          children: [
            // Game background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    blue,
                    green,
                  ],
                ),
              ),
            ),
            // Player 1
            Positioned(
              left: player1X,
              top: player1Y,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    player1X += details.delta.dx;
                    player1Y += details.delta.dy;
                  });
                },
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
            ),
            // Player 2
            Positioned(
              left: player2X,
              top: player2Y,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    player2X += details.delta.dx;
                    player2Y += details.delta.dy;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.green,
                  child: const Center(
                    child: Text(
                      'Player 2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
