import 'package:brick_breaker/features/game/components/arena.dart';
import 'package:brick_breaker/features/game/components/brick_wall.dart';
import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/painting.dart';

class Ball extends BodyComponent<Forge2dGameWorld> with ContactCallbacks {
  final Vector2 ballPosition;
  final double radius;

  Ball({required this.ballPosition, required this.radius});

  final _gradient = RadialGradient(
    center: Alignment.topLeft,
    colors: [
      const HSLColor.fromAHSL(1.0, 0.0, 0.0, 1.0).toColor(),
      const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.9).toColor(),
      const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.5).toColor(),
    ],
    stops: const [0.0, 0.5, 1.0],
    radius: 0.95,
  );

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Arena) {
      body.linearVelocity = Vector2(75.0, 75.0);
    } else if (other is BrickWall) {
      body.linearVelocity = Vector2(100.0, 100.0);
    }
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is Arena) {
      body.linearVelocity = Vector2(75.0, 75.0);
    } else if (other is BrickWall) {
      body.linearVelocity = Vector2(100.0, 100.0);
    }
  }

  @override
  void render(Canvas canvas) {
    final circle = body.fixtures.first.shape as CircleShape;

    final paint = Paint()
      ..shader = _gradient.createShader(Rect.fromCircle(
        center: circle.position.toOffset(),
        radius: radius,
      ))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(circle.position.toOffset(), radius, paint);
  }

  void reset() {
    body.setTransform(ballPosition, angle);
    body.angularVelocity = 0.0;
    body.linearVelocity = Vector2.zero();
  }

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
