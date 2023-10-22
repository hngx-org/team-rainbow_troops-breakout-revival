import 'dart:math';

import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class PaddlePower extends BodyComponent<Forge2dGameWorld>
    with HasGameRef<Forge2dGameWorld>, ContactCallbacks {
  final Vector2 pPowerPosition;

  PaddlePower({required this.pPowerPosition});

  /* final _gradient = RadialGradient(
    center: Alignment.topLeft,
    colors: [
      const HSLColor.fromAHSL(1.0, 0.0, 0.0, 1.0).toColor(),
      const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.9).toColor(),
      const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.5).toColor(),
    ],
    stops: const [0.0, 0.5, 1.0],
    radius: 0.95,
  ); */

  Random rnd = Random();
  late final ParticleSystemComponent particleComponent;

  Vector2 randomVectorGenerator() =>
      ((Vector2.random(rnd)) - Vector2.random(rnd)) * 500;

  // @override
  // Future<void> onLoad() {
  //   particleComponent = ParticleSystemComponent(
  //       particle: particle.Particle.generate(
  //     count: 20,
  //     lifespan: 0.3,
  //     generator: (i) => particle.AcceleratedParticle(
  //       acceleration: randomVectorGenerator(),
  //       speed: randomVectorGenerator(),
  //       position: ballPosition.clone(),
  //       child: particle.CircleParticle(
  //         radius: 1,
  //         paint: Paint()..color = AppColors.playerColor,
  //       ),
  //     ),
  //   ));
  //   return super.onLoad();
  // }

  @override
  void beginContact(Object other, Contact contact) {}

  @override
  void render(Canvas canvas) {}

  void reset() {
    body.setTransform(pPowerPosition, angle);
    body.angularVelocity = 0.0;
    body.linearVelocity = Vector2.zero();
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..userData = this
      ..type = BodyType.static
      ..position = pPowerPosition
      ..angularDamping = 1.0
      ..linearDamping = 1.0;

    final pPowerBody = world.createBody(bodyDef);

    final shape = PolygonShape()
      ..setAsBox(
        10,
        10,
        Vector2(0.0, 0.0),
        0.0,
      );

    pPowerBody.createFixture(
      FixtureDef(shape)
        ..density = 100.0
        ..friction = 0.0
        ..restitution = 0.1,
    );

    return pPowerBody;
  }
}
