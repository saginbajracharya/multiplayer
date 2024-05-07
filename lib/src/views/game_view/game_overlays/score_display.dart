import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:multiplayer/src/views/game_view/doodle_dash.dart';

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({super.key, required this.game, this.isLight = false});

  final Game game;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (game as DoodleDash).gameManager.score,
      builder: (context, value, child) {
        return Center(child: Text('Score: $value',style: Theme.of(context).textTheme.bodyLarge!));
      },
    );
  }
}
