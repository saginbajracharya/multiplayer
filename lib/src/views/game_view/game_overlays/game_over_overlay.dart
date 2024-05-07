import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:multiplayer/src/views/game_view/doodle_dash.dart';
import 'package:multiplayer/src/views/game_view/game_overlays/main_menu_overlay.dart';
import 'package:multiplayer/src/views/game_view/game_overlays/score_display.dart';

// Overlay that pops up when the game ends
class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay(this.game, {super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Game Over',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(),
              ),
              const WhiteSpace(height: 50),
              ScoreDisplay(
                game: game,
                isLight: true,
              ),
              const WhiteSpace(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  (game as DoodleDash).resetGame();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(200, 75),
                  ),
                  textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.titleLarge),
                ),
                child: const Text('Play Again'),
              ),
              const WhiteSpace(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  (game as DoodleDash).gotoMenu();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(200, 75),
                  ),
                  textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.titleLarge),
                ),
                child: const Text('Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
