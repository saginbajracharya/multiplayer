import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:multiplayer/src/common/styles.dart';

class MyWorld extends World with TapCallbacks {
  @override
  Future<void> onLoad() async {
    add(Square(Vector2.zero()));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!event.handled) {
      final touchPoint = event.localPosition;
      add(Square(touchPoint));
    }
  }
}

class Square extends RectangleComponent with TapCallbacks {
  static const speed = 1;
  static const squareSize = 128.0;
  static const indicatorSize = 6.0;

  Square(Vector2 position)
  : super(
    position: position,
    size: Vector2.all(squareSize),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      RectangleComponent(
        size: Vector2.all(indicatorSize),
        paint: FlameColors.blue,
      ),
    );
    add(
      RectangleComponent(
        position: size / 2,
        size: Vector2.all(indicatorSize),
        anchor: Anchor.center,
        paint: FlameColors.red,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += speed * dt;
    angle %= 2 * math.pi;
  }

  @override
  void onTapDown(TapDownEvent event) {
    removeFromParent();
    event.handled = true;
  }
}