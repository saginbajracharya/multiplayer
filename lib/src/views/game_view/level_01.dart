import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:multiplayer/src/views/game_view/doodle_dash.dart';
import 'package:multiplayer/src/views/game_view/game_overlays/game_over_overlay.dart';
import 'package:multiplayer/src/views/game_view/game_overlays/game_overlay.dart';
import 'package:multiplayer/src/views/game_view/game_overlays/main_menu_overlay.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/widgets/animated_bg.dart';

final Game game = DoodleDash();

class Level01 extends StatefulWidget {
  const Level01({super.key});

  static const routeName = '/level01';

  @override
  State<Level01> createState() => _Level01State();
}

class _Level01State extends State<Level01> {
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackgroundScaffold(
        padding: EdgeInsets.zero,
        child: GameWidget(
          game: game,
          loadingBuilder: (loadingBuilder){
            return Center(
              child: Container(
                color: transparent,
                child: const Center(
                  child: Text('Loading',style: TextStyle(color: red,fontSize: 25))
                ),
              ),
            );
          },
          errorBuilder : (errorBuilder,obj){
            return Center(
              child: Container(
                color: transparent,
                child: const Center(
                  child: Text('Error',style: TextStyle(color: red,fontSize: 25))
                ),
              ),
            );
          },
          backgroundBuilder :(backgroundBuilder){
            return Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: transparent,
                ),
              ),
            );
          },
          overlayBuilderMap: <String, Widget Function(BuildContext,Game)>{
            'gameOverlay'    : (context, game) => GameOverlay(game),
            'mainMenuOverlay': (context, game) => MainMenuOverlay(game),
            'gameOverOverlay': (context, game) => GameOverOverlay(game),
          },
        ),
      ),
    );
  }
}