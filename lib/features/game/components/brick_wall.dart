import 'dart:async';

import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:brick_breaker/features/game/components/game_brick.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class BrickWall extends Component with HasGameRef<Forge2dGameWorld> {
  final Vector2 position;
  final Size? size;
  final int rows;
  final int columns;
  final double gap;

  BrickWall(
      {Vector2? position, this.size, int? rows, int? columns, double? gap})
      : position = position ?? Vector2.zero(),
        rows = rows ?? 1,
        columns = columns ?? 1,
        gap = gap ?? 0.1;

  @override
  void update(double dt) {
    for (final child in children) {
      if (child is WallBrick && child.destroyed) {
        for (final fixture in [...child.body.fixtures]) {
          child.body.destroyFixture(fixture);
        }
        gameRef.world.destroyBody(child.body);
        remove(child);
      }
    }
    super.update(dt);
  }

  @override
  Future<FutureOr<void>> onLoad() async {
    await _buildWall();
  }

  Future<void> _buildWall() async {
    final wallSize = size ??
        Size(
          gameRef.size.x,
          gameRef.size.y * 0.25,
        );

    final brickSize = Size(
      ((wallSize.width - gap * 2.0) - (columns - 1) * gap) / columns,
      (wallSize.height - (rows - 1) * gap) / rows,
    );

    var brickPosition = Vector2(
      brickSize.width / 2.0 + gap,
      brickSize.height / 2.0 + position.y,
    );

    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        await add(WallBrick(
          size: brickSize,
          brickPosition: brickPosition,
        ));
        brickPosition += Vector2(brickSize.width + gap, 0.0);
      }
      brickPosition += Vector2(
        (brickSize.width / 2.0 + gap) - brickPosition.x,
        brickSize.height + gap,
      );
    }
  }
}
