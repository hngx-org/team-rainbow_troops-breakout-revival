import 'dart:math';

import 'package:brick_breaker/features/game/components/ball.dart';
import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:brick_breaker/features/game/constants.dart';
import 'package:brick_breaker/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flame/particles.dart' as particle;

class WallBrick extends BodyComponent<Forge2dGameWorld> with ContactCallbacks {
  final Size size;
  final Color color;
  final Vector2 brickPosition;

  WallBrick(
      {required this.size, required this.color, required this.brickPosition});

  BrickState brickState = BrickState.normal;
  late final ParticleSystemComponent particleComponent;

  Random rnd = Random();

  Vector2 randomVectorGenerator() =>
      ((Vector2.random(rnd)) - Vector2.random(rnd)) * 800;
  @override
  Future<void> onLoad() {
    // final brickSprite = Sprite(game.images.fromCache('brick_seven.png'));
    // add(
    //   SpriteComponent(
    //     sprite: brickSprite,
    //     size: Vector2(size.width, size.height),
    //     anchor: Anchor.center,
    //   ),
    // );
    particleComponent = ParticleSystemComponent(
        particle: particle.Particle.generate(
      count: 50,
      lifespan: 0.5,
      generator: (i) => particle.AcceleratedParticle(
        acceleration: randomVectorGenerator(),
        speed: randomVectorGenerator(),
        position: brickPosition.clone(),
        child: particle.CircleParticle(
          radius: 1,
          paint: Paint()..color = AppColors.brickColorPrimary,
        ),
      ),
    ));
    return super.onLoad();
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      hit();
      game.add(particleComponent);
      // game.add(
      //   SpriteAnimationComponent(
      //       animation: game.cracker.clone(),
      //       anchor: Anchor.center,
      //       position: body.position,
      //       size: Vector2(size.width * 4.0, size.height * 4.0),
      //       removeOnFinish: true),
      // );
    }
    super.beginContact(other, contact);
  }

  void hit() {
    if (brickState == BrickState.normal) {
      brickState = BrickState.destroyed;
      debugPrint('$brickState ${body.isActive} ${body.toString()}');
    }
  }

  @override
  void render(Canvas canvas) {
    if (body.fixtures.isEmpty) {
      return;
    }

    final rectangle = body.fixtures.first.shape as PolygonShape;

    final paint = Paint()
      ..color = color
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
