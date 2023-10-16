import 'package:brick_breaker/features/game/components/arena.dart';
import 'package:brick_breaker/features/game/components/ball.dart';
import 'package:brick_breaker/features/game/components/brick_wall.dart';
import 'package:brick_breaker/features/game/components/dead_zone.dart.dart';
import 'package:brick_breaker/features/game/components/paddle.dart';
import 'package:brick_breaker/features/game/constants.dart';
import 'package:brick_breaker/features/game/sound/breakout_revival_audio.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';

Vector2 getSpritePositionInSheet(
    int spriteIndex, int columns, double spriteWidth, double spriteHeight) {
  final row = spriteIndex ~/ columns; // Calculate the row.
  final col = spriteIndex % columns; // Calculate the column.
  final x = col * spriteWidth; // Calculate the x-coordinate.
  final y = row * spriteHeight; // Calculate the y-coordinate.

  return Vector2(x, y);
}

///GameLoop where everything loads, initializes and updates.
class Forge2dGameWorld extends Forge2DGame with DragCallbacks, TapCallbacks {
  late final Ball _ball;
  late final Arena _arena;
  late final Paddle _paddle;
  late final BrickWall brickWall;
  late final DeadZone _deadZone;

  ///We have set the gravity in the game to zero and zoom the camera.
  Forge2dGameWorld() : super(gravity: Vector2.zero(), zoom: 20);

  GameState gameState = GameState.initializing;
  GameLevel gameLevel = GameLevel.one;

  ///Called when user taps on the screen
  @override
  void onTapDown(TapDownEvent event) {
    if (gameState == GameState.ready) {
      overlays.remove('PreGame');
      if (gameLevel.name.isNotEmpty) {
        _ball.playLevel(gameLevel.index + 1);
      }
      debugPrint(_ball.body.linearVelocity.toString());
      gameState = GameState.running;
    }
    super.onTapDown(event);
  }

  ///This is the load method where all the game components are initialized and
  ///loaded inside the game loop.
  @override
  Future<void> onLoad() async {
    await loadSprite('ice_paddle.png');
    await loadSprite('wood_paddle.png');
    await loadSprite('brick_ten.png');
    await loadSprite('brick_nine.png');
    await loadSprite('brick_seven.png');
    await loadSprite('brick_five.png');
    breakoutAudio.loadAssets();
    _initializeGame();
  }

  ///AudioPlayer instance
  final breakoutAudio = BreakoutRevivalAudioPlayer();

  Future<void> _initializeGame() async {
    ///AppBar with level
    overlays.add('GameLevel');
    //Arena is the game playing ground.
    _arena = Arena();
    await add(_arena);

    //initialization of the ball
    _ball = Ball(
      ballPosition: Vector2(size.x / 2.0, size.y / 2.0 + 10.0),
      radius: 5.0,
    );
    await add(_ball);

    //initialization of brick wall
    final brickWallPosition = Vector2(0.0, size.y * 0.075);

    brickWall =
        BrickWall(position: brickWallPosition, rows: 2, columns: 5, gap: 0.5);
    await add(brickWall);

//initialization of dead zone if the player goes down this region game is over.
    final deadZonePosition =
        Vector2(size.x / 2.0, size.y - (size.y * 0.1) / 2.0);
    final deadZoneSize = Size(size.x, size.y * 0.1);

    _deadZone = DeadZone(
      size: deadZoneSize,
      deadZonePosition: deadZonePosition,
    );
    await add(_deadZone);

//Paddle is where player comes into play. This is the component which has drag
//callbacks so that user can move the paddle to play game.
    const paddleSize = Size(60.0, 8.0);

    final paddlePosition = Vector2(
      size.x / 2.0,
      size.y - deadZoneSize.height - paddleSize.height / 2.0,
    );

    _paddle = Paddle(
      size: paddleSize,
      ground: _arena,
      paddlePosition: paddlePosition,
    );

    await add(_paddle);
    gameState = GameState.ready;
    overlays.add('PreGame');
  }

  ///Reset Game method to be called at postGame state Won/Lost
  Future<void> resetGame() async {
//Game state initializing with resetting components to their initial position
    gameState = GameState.initializing;
    _ball.reset();
    _paddle.reset();
    await brickWall.reset();

    //remove post game widget and add preGame
    overlays.remove('PostGame');
    overlays.add('PreGame');

    //Game State Ready
    gameState = GameState.ready;
    //Resume the game engine
    resumeEngine();
  }

  Future<void> moveToNextLevel() async {
    gameState = GameState.initializing;
    _ball.reset();
    _paddle.reset();
    final brickWallPosition = Vector2(0.0, size.y * 0.075);
    final brickLevel = List.generate(
        5,
        (i) => brickWall.copyWith(
            position: brickWallPosition,
            rows: (i + 3) ~/ 2,
            columns: (i + 8) ~/ 2,
            gap: 1.0));
    gameState = GameState.initializing;
    if (gameLevel.name.isNotEmpty) {
      BrickWall brickWallAtLevel = brickLevel[gameLevel.index];
      await add(brickWallAtLevel);
    }
    debugPrint('gameLevel: $gameLevel ');
    //resetting of brick wall to next level
    await brickWall.resetToNextLevel();
    //Game State Ready
    gameState = GameState.ready;

//remove post game widget and add preGame
    overlays.remove('PostGame');
    overlays.add('PreGame');

    //Resume the game engine
    resumeEngine();
  }

  // ///To set the level of the game
  // Future<void> setBallLevel() async {
  //   if (gameLevel == GameLevel.two) {
  //     _ball.playLevel(2);
  //   } else if (gameLevel == GameLevel.three) {
  //     _ball.playLevel(3);
  //   } else if (gameLevel == GameLevel.four) {
  //     _ball.playLevel(4);
  //   } else {
  //     _ball.playLevel(5);
  //   }
  // }

  /// For After initialization updates
  @override
  void update(double dt) {
    super.update(dt);
    if (gameState == GameState.lost || gameState == GameState.won) {
      pauseEngine();
      overlays.add('PostGame');
    }
  }
}
