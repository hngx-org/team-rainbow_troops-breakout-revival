// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brick_breaker/features/game/components/ball.dart';
import 'package:brick_breaker/features/game/constants.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';

class DeadZone extends BodyComponent<Forge2dGameWorld> with ContactCallbacks {
  final Size size;
  final Vector2 deadZonePosition;
  DeadZone({
    required this.size,
    required this.deadZonePosition,
  });

  @override
  bool get renderBody => false;

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..userData = this
      ..position = deadZonePosition;

    final zoneBody = world.createBody(bodyDef);

    final shape = PolygonShape()
      ..setAsBox(
        size.width / 2.0,
        size.height / 2.0,
        Vector2.zero(),
        0.0,
      );

    zoneBody.createFixture(FixtureDef(shape)..isSensor = true);

    return zoneBody;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      game.gameState = GameState.lost;
    }
  }
}
