import 'package:brick_breaker/features/game/components/arena.dart';
import 'package:brick_breaker/features/game/components/ball.dart';
import 'package:brick_breaker/features/game/components/brick_wall.dart';
import 'package:brick_breaker/features/game/components/dead_zone.dart.dart';
import 'package:brick_breaker/features/game/components/paddle.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

enum GameState {
  initializing,
  ready,
  running,
  paused,
  won,
  lost,
}

class Forge2dGameWorld extends Forge2DGame with DragCallbacks {
  Ball? _ball;
  Forge2dGameWorld() : super(gravity: Vector2.zero(), zoom: 20);

  GameState gameState = GameState.initializing;

  @override
  Future<void> onLoad() async {
    await _initializeGame();
    _ball?.body.applyLinearImpulse(Vector2(-6000, -6000));
  }

  Future<void> _initializeGame() async {
    final arena = Arena();
    await add(arena);

    _ball = Ball(
      ballPosition: size / 2,
      radius: 5.0,
    );
    await add(_ball!);

    final brickWallPosition = Vector2(0.0, size.y * 0.075);

    final brickWall = BrickWall(
      position: brickWallPosition,
      rows: 5,
      columns: 6,
      gap: 0.5,
    );

    await add(brickWall);

    final deadZonePosition =
        Vector2(size.x / 2.0, size.y - (size.y * 0.1) / 2.0);
    final deadZoneSize = Size(size.x, size.y * 0.1);

    final deadZone = DeadZone(
      size: deadZoneSize,
      deadZonePosition: deadZonePosition,
    );
    await add(deadZone);

    const paddleSize = Size(60.0, 8.0);

    final paddlePosition = Vector2(
      size.x / 2.0,
      size.y - deadZoneSize.height - paddleSize.height / 2.0,
    );

    final paddle = Paddle(
      size: paddleSize,
      ground: arena,
      paddlePosition: paddlePosition,
    );

    await add(paddle);
    gameState = GameState.ready;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameState == GameState.lost) {
      pauseEngine();
    }
  }
}
