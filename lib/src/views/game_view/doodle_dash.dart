import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:multiplayer/src/managers/managers.dart';
import 'package:multiplayer/src/sprites/sprites.dart';
import './world.dart';

enum Character { dash, sparky }

class DoodleDash extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {
  DoodleDash({super.children});
  final WorldView _world = WorldView();
  LevelManager levelManager = LevelManager();
  GameManager gameManager = GameManager();
  int screenBufferSpace = 900;
  ObjectManager objectManager = ObjectManager();
  late Player player;

  @override
  Future<void> onLoad() async {
    camera = CameraComponent.withFixedResolution(
      width: 1280 / 2,
      height: 900,
      world: world, // Assuming you have a World instance
    );
    add(camera);
    await add(_world);
    await add(gameManager);
    await add(levelManager);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameManager.isGameOver) {
      return;
    }
    if (gameManager.isIntro) {
      overlays.add('mainMenuOverlay');
      return;
    }
    if (gameManager.isPlaying) {
      checkLevelUp();
      final Rectangle worldBounds = Rectangle.fromLTRB(
        0,
        camera.viewport.position.y - screenBufferSpace,
        camera.viewport.position.x,
        camera.viewport.position.y + _world.size.y,
      );
      camera.setBounds(worldBounds);
      var isInTopHalfOfScreen = player.position.y <= (_world.size.y / 2);
      if (!player.isMovingDown && isInTopHalfOfScreen) {
        camera.follow(player);
      }

      if (player.position.y > camera.viewport.position.y + _world.size.y + player.size.y + screenBufferSpace) {
        onLose();
      }
    }
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 241, 247, 249);
  } 

  void initializeGameStart() {
    setCharacter();
    gameManager.reset();

    if (children.contains(objectManager)) objectManager.removeFromParent();
    levelManager.reset();
    player.reset();
    camera.setBounds(
      Rectangle.fromLTRB(
        0,
        -_world.size.y, // top of screen is 0, so negative is already off screen
        camera.viewport.size.x,
        _world.size.y + screenBufferSpace, // makes sure bottom bound of game is below bottom of screen
      )
    );
    camera.follow(
      player,
    );
    // player.resetPosition();
    objectManager = ObjectManager(
      minVerticalDistanceToNextPlatform: levelManager.minDistance,
      maxVerticalDistanceToNextPlatform: levelManager.maxDistance
    );
    add(objectManager);
    objectManager.configure(levelManager.level, levelManager.difficulty);
  }

  void setCharacter() {
    player = Player(
      character: gameManager.character,
      jumpSpeed: levelManager.startingJumpSpeed,
    );
    add(player);
  }

  void startGame() {
    initializeGameStart();
    gameManager.state = GameState.playing;
    overlays.remove('mainMenuOverlay');
    overlays.add('gameOverlay');
  }

  void resetGame() {
    startGame();
    overlays.remove('gameOverOverlay');
  }

  void onLose() {
    gameManager.state = GameState.gameOver;
    player.removeFromParent();
    overlays.add('gameOverOverlay');
  }

  void togglePauseState() {
    if (paused) {
      resumeEngine();
    } else {
      pauseEngine();
    }
  }

  void checkLevelUp() {
    if (levelManager.shouldLevelUp(gameManager.score.value)) {
      levelManager.increaseLevel();
      objectManager.configure(levelManager.level, levelManager.difficulty);
      player.setJumpSpeed(levelManager.jumpSpeed);
    }
  }

  void gotoMenu(){
    gameManager.state = GameState.intro;
    if (children.contains(objectManager)) objectManager.removeFromParent();
    player.removeFromParent();
    levelManager.reset();
    gameManager.reset();
    levelManager.reset();
    overlays.remove('gameOverlay');
    overlays.remove('gameOverOverlay');
    overlays.add('mainMenuOverlay');
  }
}
