import 'dart:math';

import 'package:brick_breaker/features/game/components/arena.dart';
import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:brick_breaker/features/game/components/game_brick.dart';
import 'package:brick_breaker/features/game/components/paddle.dart';
import 'package:brick_breaker/features/game/constants.dart';
import 'package:brick_breaker/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/particles.dart' as particle;
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Ball extends BodyComponent<Forge2dGameWorld>
    with HasGameRef<Forge2dGameWorld>, ContactCallbacks {
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

  Random rnd = Random();
  late final ParticleSystemComponent particleComponent;

  Vector2 randomVectorGenerator() =>
      ((Vector2.random(rnd)) - Vector2.random(rnd)) * 500;

  @override
  Future<void> onLoad() {
    particleComponent = ParticleSystemComponent(
        particle: particle.Particle.generate(
      count: 20,
      lifespan: 0.3,
      generator: (i) => particle.AcceleratedParticle(
        acceleration: randomVectorGenerator(),
        speed: randomVectorGenerator(),
        position: ballPosition.clone(),
        child: particle.CircleParticle(
          radius: 1,
          paint: Paint()..color = AppColors.playerColor,
        ),
      ),
    ));
    return super.onLoad();
  }

  @override
  void beginContact(Object other, Contact contact) {
    switch (gameRef.gameLevel) {
      case GameLevel.one:
        if (other is Arena) {
          body.linearVelocity = Vector2(100.0, -100.0);
        } else if (other is WallBrick) {
          game.breakoutAudio.playRockBreaking();

          body.linearVelocity = Vector2(150.0, 150.0);
        } else if (other is Paddle) {
          game.add(particleComponent);
          body.linearVelocity = Vector2(-100, -100);
        }
        break;
      case GameLevel.two:
        if (other is Arena) {
          body.linearVelocity = Vector2(150.0, -150.0);
        } else if (other is WallBrick) {
          game.breakoutAudio.playRockBreaking();
          body.linearVelocity = Vector2(200.0, 200.0);
        } else if (other is Paddle) {
          body.linearVelocity = Vector2(170.0, 170.0);
          gameRef.add(particleComponent);
        }
        break;
      case GameLevel.three:
        if (other is Arena) {
          body.linearVelocity = Vector2(180.0, -180.0);
        } else if (other is WallBrick) {
          game.breakoutAudio.playRockBreaking();
          body.linearVelocity = Vector2(250.0, 250.0);
        } else if (other is Paddle) {
          body.linearVelocity = Vector2(170.0, 170.0);
          gameRef.add(particleComponent);
        }
        break;
      case GameLevel.four:
        if (other is Arena) {
          body.linearVelocity = Vector2(210.0, -210.0);
        } else if (other is WallBrick) {
          game.breakoutAudio.playRockBreaking();
          body.linearVelocity = Vector2(300.0, 300.0);
        } else if (other is Paddle) {
          body.linearVelocity = Vector2(170.0, 170.0);
          gameRef.add(particleComponent);
        }
        break;
      case GameLevel.five:
        if (other is Arena) {
          body.linearVelocity = Vector2(240.0, -240.0);
        } else if (other is WallBrick) {
          game.breakoutAudio.playRockBreaking();
          body.linearVelocity = Vector2(350.0, 350.0);
        } else if (other is Paddle) {
          body.linearVelocity = Vector2(170.0, 170.0);
          gameRef.add(particleComponent);
        }
        break;
      default:
        if (other is Arena) {
          body.linearVelocity = Vector2(120.0, -120.0);
        } else if (other is WallBrick) {
          body.linearVelocity = Vector2(150.0, 150.0);
          game.breakoutAudio.playRockBreaking();
          body.linearVelocity = Vector2(150.0, 150.0);
        } else if (other is Paddle) {
          body.linearVelocity = Vector2(170.0, 170.0);
          gameRef.add(particleComponent);
        }
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

  void playLevel(int level) {
    if (level == 1) {
      body.linearVelocity = Vector2(150.0, 150.0);
    } else if (level == 2) {
      body.linearVelocity = Vector2(180.0, 180.0);
    } else if (level == 3) {
      body.linearVelocity = Vector2(220.0, 220.0);
    } else if (level == 4) {
      body.linearVelocity = Vector2(250.0, 250.0);
    } else if (level == 5) {
      body.linearVelocity = Vector2(300.0, 300.0);
    }
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
      ..density = 1
      ..restitution = 1.0);
    return ball;
  }
}
