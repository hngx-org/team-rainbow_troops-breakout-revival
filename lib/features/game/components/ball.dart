import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Ball extends BodyComponent<Forge2dGameWorld> {
  final Vector2 ballPosition;
  final double radius;

  Ball({required this.ballPosition, required this.radius});

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..userData = this
      ..type = BodyType.dynamic
      ..position = ballPosition;

    final ball = world.createBody(bodyDef);

    final shape = CircleShape()..radius = radius;

    final fixtureDef = FixtureDef(shape);

    ball.createFixture(fixtureDef
      ..density = 1.0
      ..restitution = 1.0);
    return ball;
  }
}
