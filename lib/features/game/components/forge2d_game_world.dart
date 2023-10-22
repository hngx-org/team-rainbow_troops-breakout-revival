import 'package:brick_breaker/features/game/components/arena.dart';
import 'package:brick_breaker/features/game/components/ball.dart';
import 'package:brick_breaker/features/game/components/brick_wall.dart';
import 'package:brick_breaker/features/game/components/dead_zone.dart.dart';
import 'package:brick_breaker/features/game/components/paddle.dart';
import 'package:brick_breaker/features/game/constants.dart';
import 'package:brick_breaker/features/game/sound/breakout_revival_audio.dart';
import 'package:brick_breaker/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

///GameLoop where everything loads, initializes and updates.
class Forge2dGameWorld extends Forge2DGame with DragCallbacks, TapCallbacks {
  late final Ball _ball;
  late final Arena _arena;
  late final Paddle _paddle;
  BrickWall? brickWall;
  BrickWall? brickWallNextLevel;
  late final DeadZone _deadZone;
  late SpriteAnimation cracker;

  ///We have set the gravity in the game to zero and zoom the camera.
  Forge2dGameWorld() : super(gravity: Vector2.zero(), zoom: 20);

  GameState gameState = GameState.initializing;
  GameLevel gameLevel = GameLevel.one;
  PowerState powerState = PowerState.notOn;

  @override
  Color backgroundColor() => AppColors.backgroundColor;

  ///Called when user taps on the screen
  @override
  void onTapDown(TapDownEvent event) {
    if (gameState == GameState.ready) {
      overlays.remove('PreGame');
      breakoutAudio.playBackgroundMusic();
      if (gameLevel.name.isNotEmpty) {
        _ball.playLevel(gameLevel.index + 1);
      }
      debugPrint(
          '${_ball.body.linearVelocity.toString()} ${gameLevel.index + 1}');
      gameState = GameState.running;
    }
    super.onTapDown(event);
  }

  ///This is the load method where all the game components are initialized and
  ///loaded inside the game loop.
  @override
  Future<void> onLoad() async {
    FlameAudio.bgm.initialize();
    await loadSprite('ice_paddle.png');
    await loadSprite('brick_explode.png');
    await loadSprite('wood_paddle.png');
    await loadSprite('brick_ten.png');
    await loadSprite('brick_nine.png');
    await loadSprite('brick_seven.png');
    await loadSprite('brick_five.png');
    final sprites = SpriteSheet(
        image: images.fromCache('brick_explode.png'),
        srcSize: Vector2.all(256));

    cracker = SpriteAnimation.fromFrameData(
      images.fromCache('brick_explode.png'),
      SpriteAnimationData([
        sprites.createFrameDataFromId(0, stepTime: 0.005),
        sprites.createFrameDataFromId(1, stepTime: 0.005),
        sprites.createFrameDataFromId(2, stepTime: 0.01),
        sprites.createFrameDataFromId(3, stepTime: 0.01),
        sprites.createFrameDataFromId(4, stepTime: 0.01),
        sprites.createFrameDataFromId(5, stepTime: 0.01),
        sprites.createFrameDataFromId(6, stepTime: 0.01),
        // sprites.createFrameDataFromId(7, stepTime: 0.01),
        // sprites.createFrameDataFromId(8, stepTime: 0.01),
        // sprites.createFrameDataFromId(9, stepTime: 0.01),
        // sprites.createFrameDataFromId(10, stepTime: 0.01),
        // sprites.createFrameDataFromId(11, stepTime: 0.01),
        // sprites.createFrameDataFromId(12, stepTime: 0.01),
        // sprites.createFrameDataFromId(13, stepTime: 0.01),
        // sprites.createFrameDataFromId(14, stepTime: 0.01),
        // sprites.createFrameDataFromId(15, stepTime: 0.01),
        // sprites.createFrameDataFromId(16, stepTime: 0.01),
        // sprites.createFrameDataFromId(17, stepTime: 0.01),
        // sprites.createFrameDataFromId(18, stepTime: 0.01),
        // sprites.createFrameDataFromId(19, stepTime: 0.01),
        // sprites.createFrameDataFromId(20, stepTime: 0.01),
        sprites.createFrameDataFromId(21, stepTime: 0.01),
        sprites.createFrameDataFromId(22, stepTime: 0.01),
        sprites.createFrameDataFromId(23, stepTime: 0.01),
        sprites.createFrameDataFromId(24, stepTime: 0.01),
        sprites.createFrameDataFromId(25, stepTime: 0.01),
        sprites.createFrameDataFromId(26, stepTime: 0.01),
        sprites.createFrameDataFromId(27, stepTime: 0.01),
        sprites.createFrameDataFromId(28, stepTime: 0.01),
        sprites.createFrameDataFromId(29, stepTime: 0.01),
        sprites.createFrameDataFromId(30, stepTime: 0.01),
        sprites.createFrameDataFromId(31, stepTime: 0.01),
      ], loop: false),
    );
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
        BrickWall(position: brickWallPosition, rows: 1, columns: 3, gap: 0.5);
    await add(brickWall!);

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
  Future<void> resetGame(bool isCompleted) async {
//Game state initializing with resetting components to their initial position
    gameState = GameState.initializing;
    _ball.reset();
    _paddle.reset();
    if (isCompleted) {
      gameLevel = GameLevel.values[gameLevel.index - 1];
    }
    if (brickWallNextLevel != null) {
      await brickWallNextLevel?.reset();
    } else {
      await brickWall?.reset();
    }

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

    ///initializing new instance of the brick wall
    final brickWallPosition = Vector2(0.0, size.y * 0.075);

    final brickLevel = List.generate(
        5,
        (i) => BrickWall(
            position: brickWallPosition,
            rows: i + 2,
            columns: i + 2,
            gap: 1.0));

    //Removing the old brickWall before adding new one.
    if (brickWall != null) {
      world.remove(brickWall!);
    } else if (brickWallNextLevel != null) {
      world.remove(brickWallNextLevel!);
    }

    if (gameLevel.name.isNotEmpty) {
      brickWallNextLevel = brickLevel[gameLevel.index];
      debugPrint(
          '${gameLevel.index.toString()} ${gameLevel.name} ${gameState.toString()} ${brickWallNextLevel?.children.toString()}');
      await add(brickWallNextLevel!);
      debugPrint(
          '${gameLevel.index.toString()} ${gameLevel.name} ${gameState.toString()} ${brickWallNextLevel?.children.toString()}');
    }

    // resetting of brick wall to next level
    if (brickWall != null) {
      await brickWall?.reset();
    } else {
      await brickWallNextLevel?.reset();
    }

    debugPrint('gameLevel: $gameLevel ');

    //Game State Ready
    gameState = GameState.ready;

    //remove post game widget and add preGame
    overlays.remove('PostGame');
    overlays.add('PreGame');

    //Resume the game engine
    resumeEngine();
  }

  void pause() {
    if (gameState == GameState.running) {
      gameState = GameState.paused;
      debugPrint(gameState.toString());
    } else if (gameState == GameState.paused) {
      gameState = GameState.running;
      resumeEngine();
      debugPrint(gameState.toString());
    }
  }

  /// For After initialization updates
  @override
  void update(double dt) async {
    super.update(dt);
    if (gameState == GameState.lost || gameState == GameState.won) {
      await FlameAudio.bgm.pause();
      pauseEngine();
      overlays.add('PostGame');
    }
    if (gameState == GameState.paused) {
      await FlameAudio.bgm.pause();
      pauseEngine();
    }
  }
}
