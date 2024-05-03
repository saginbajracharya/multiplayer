import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:multiplayer/src/views/game_view/myworld_view.dart';

class Level01 extends StatefulWidget {
  const Level01({super.key});

  static const routeName = '/level01';

  @override
  State<Level01> createState() => _Level01State();
}

class _Level01State extends State<Level01> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: FlameGame(world: MyWorld()),
      ),
    );
  }
}