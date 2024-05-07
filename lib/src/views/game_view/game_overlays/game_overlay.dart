import 'dart:io' show Platform;
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/managers/game_manager.dart';
import 'package:multiplayer/src/views/game_view/doodle_dash.dart';
import 'package:multiplayer/src/views/game_view/game_overlays/score_display.dart';
import 'package:multiplayer/src/views/game_view/level_01.dart';
// import 'package:multiplayer/src/views/game_view/level_01.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverlay> createState() => GameOverlayState();
}

class GameOverlayState extends State<GameOverlay> {
  GameManager gameManager = GameManager();
  bool isPaused = false;
  final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: transparent,
      child: Stack(
        children: [
          //Back Button
          Positioned(
            top: 40,
            left: 20,
            child: OutlinedButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero),
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 48,
              ),
              onPressed: () {
                (game as DoodleDash).gotoMenu();
              },
            ),
          ),
          //Score Display
          Positioned(
            top: 50,
            right: 0,
            left: 0,
            child: ScoreDisplay(game: widget.game),
          ),
          //Play/Pause Button
          Positioned(
            top: 40,
            right: 20,
            child: OutlinedButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero),
              ),
              child: isPaused
              ? const Icon(
                Icons.play_arrow,
                size: 48,
              )
              : const Icon(
                Icons.pause,
                size: 48,
              ),
              onPressed: () {
                (widget.game as DoodleDash).togglePauseState();
                setState(
                  () {
                    isPaused = !isPaused;
                  },
                );
              },
            ),
          ),
          //Controls
          if (isMobile)
            Positioned(
              bottom: 20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: GestureDetector(
                        onTapDown: (details) {
                          (widget.game as DoodleDash).player.moveLeft();
                        },
                        onTapUp: (details) {
                          (widget.game as DoodleDash).player.resetDirection();
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shadowColor: Theme.of(context).colorScheme.background,
                          child: const Icon(Icons.arrow_left, size: 64),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTapDown: (details) {
                          (widget.game as DoodleDash).player.moveRight();
                        },
                        onTapUp: (details) {
                          (widget.game as DoodleDash).player.resetDirection();
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shadowColor: Theme.of(context).colorScheme.background,
                          child: const Icon(Icons.arrow_right, size: 64),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          //Pause Icon
          if (isPaused)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 72.0,
              right: MediaQuery.of(context).size.width / 2 - 72.0,
              child: const Icon(
                Icons.pause_circle,
                size: 144.0,
                color: Colors.black12,
              ),
            ),
        ],
      ),
    );
  }
}
