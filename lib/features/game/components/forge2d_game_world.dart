import 'package:brick_breaker/features/game/components/arena.dart';
import 'package:brick_breaker/features/game/components/ball.dart';
import 'package:brick_breaker/features/game/components/brick_wall.dart';
import 'package:brick_breaker/features/game/components/dead_zone.dart.dart';
import 'package:brick_breaker/features/game/components/paddle.dart';
import 'package:brick_breaker/features/game/constants.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

///GameLoop where everything loads, initializes and updates.
class Forge2dGameWorld extends Forge2DGame with DragCallbacks, TapCallbacks {
  late final Ball _ball;
  late final Arena _arena;
  late final Paddle _paddle;
  late final BrickWall _brickWall;
  late final DeadZone _deadZone;

  ///We have set the gravity in the game to zero and zoom the camera.
  Forge2dGameWorld() : super(gravity: Vector2.zero(), zoom: 20);

  GameState gameState = GameState.initializing;
  GameLevel? gameLevel;

  ///Called when user taps on the screen
  @override
  void onTapDown(TapDownEvent event) {
    if (gameState == GameState.ready) {
      overlays.remove('PreGame');
      gameLevel = GameLevel.one;
      _ball.body.linearVelocity = Vector2(50.0, 50.0);
      gameState = GameState.running;
    }
    super.onTapDown(event);
  }

  ///This is the load method where all the game components are initialized and
  ///loaded inside the game loop.
  @override
  Future<void> onLoad() async {
    await _initializeGame();
  }

  Future<void> _initializeGame() async {
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

    _brickWall = BrickWall(
      position: brickWallPosition,
      rows: 2,
      columns: 5,
      gap: 0.5,
    );

    await add(_brickWall);

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
    await _brickWall.reset();

//Game State Ready
    gameState = GameState.ready;

//remove post game widget and add preGame
    overlays.remove(overlays.activeOverlays.first);
    overlays.add('PreGame');

    //Resume the game engine
    resumeEngine();
  }

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
