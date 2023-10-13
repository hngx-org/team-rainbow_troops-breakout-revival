import 'dart:async';

import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:brick_breaker/features/game/components/game_brick.dart';
import 'package:brick_breaker/features/game/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/painting.dart';

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

    if (children.isEmpty) {
      gameRef.gameState = GameState.won;
      if (gameRef.gameLevel == GameLevel.one) {
        gameRef.gameLevel = GameLevel.two;
      } else if (gameRef.gameLevel == GameLevel.two) {
        gameRef.gameLevel = GameLevel.three;
      } else if (gameRef.gameLevel == GameLevel.three) {
        gameRef.gameLevel = GameLevel.four;
      } else if (gameRef.gameLevel == GameLevel.four) {
        gameRef.gameLevel = GameLevel.five;
      }
    }
    super.update(dt);
  }

  late final List<Color> _colors;
  @override
  Future<FutureOr<void>> onLoad() async {
    _colors = _colorSet(rows);
    await _buildWall();
  }

  Future<void> reset() async {
    removeAll(children);
    await _buildWall();
  }

  static const transparency = 1.0;
  static const saturation = 0.80;
  static const lightness = 0.5;

  List<Color> _colorSet(int count) => List<Color>.generate(
      count,
      (index) => HSLColor.fromAHSL(
              transparency, index / count * 360, saturation, lightness)
          .toColor(),
      growable: false);

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
          color: _colors[i],
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
