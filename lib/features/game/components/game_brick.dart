import 'package:brick_breaker/features/game/components/ball.dart';
import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class WallBrick extends BodyComponent<Forge2dGameWorld> with ContactCallbacks {
  final Size size;
  final Color color;
  final Vector2 brickPosition;

  WallBrick(
      {required this.size, required this.color, required this.brickPosition});

  var destroyed = false;

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      destroyed = true;
    }
  }

  @override
  Future<void> onLoad() {
    final brickSprite = Sprite(game.images.fromCache('brick_seven.png'));
    add(
      SpriteComponent(
        sprite: brickSprite,
        size: Vector2(size.width, size.height),
        anchor: Anchor.center,
      ),
    );
    return super.onLoad();
  }

  late SpriteAnimation cracker;

  @override
  void render(Canvas canvas) {
    if (body.fixtures.isEmpty) {
      return;
    }

    final rectangle = body.fixtures.first.shape as PolygonShape;

    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromCenter(
            center: rectangle.centroid.toOffset(),
            width: size.width,
            height: size.height),
        paint);
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..userData = this
      ..type = BodyType.static
      ..position = brickPosition
      ..angularDamping = 1.0
      ..linearDamping = 1.0;

    final brickBody = world.createBody(bodyDef);

    final shape = PolygonShape()
      ..setAsBox(
        size.width / 2.0,
        size.height / 2.0,
        Vector2(0.0, 0.0),
        0.0,
      );

    brickBody.createFixture(
      FixtureDef(shape)
        ..density = 100.0
        ..friction = 0.0
        ..restitution = 0.1,
    );

    return brickBody;
  }
}
