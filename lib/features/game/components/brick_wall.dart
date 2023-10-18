import 'dart:async';
import 'dart:math';
import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:brick_breaker/features/game/components/game_brick.dart';
import 'package:brick_breaker/features/game/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:brick_breaker/utils/constants.dart';

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
    // Check for bricks in the wall that have been flagged for removal.
    for (final child in [...children]) {
      if (child is WallBrick && child.destroyed) {
        for (final fixture in [...child.body.fixtures]) {
          child.body.destroyFixture(fixture);
          debugPrint(fixture.body.toString());
        }
        gameRef.world.destroyBody(child.body);
        remove(child);
        debugPrint(child.body.toString());
      }
    }

    Future.delayed(const Duration(milliseconds: 600), () {
      if (children.isEmpty && gameRef.gameState == GameState.running) {
        gameRef.gameState = GameState.won;
        debugPrint('game level before: ${gameRef.gameLevel.name}');
        gameRef.gameLevel = GameLevel.values[gameRef.gameLevel.index + 1];
        debugPrint('game level After: ${gameRef.gameLevel.name}');
      }
    });
    super.update(dt);
  }

  late final List<Color> _colors;
  late SpriteAnimation cracker;
  @override
  Future<FutureOr<void>> onLoad() async {
    _colors = _colorSet(rows);
    await _buildWall();
  }

  Future<void> reset() async {
    removeAll(children);
    await _buildWall();
    debugPrint('Level at brick: ${gameRef.gameLevel.name} $rows');
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

    // final brickSize = Size(
    //   ((wallSize.width - gap * 2.0) - (columns - 1) * gap) / columns,
    //   (wallSize.height - (rows - 1) * gap) / rows,
    // );

    // Calculate the number of rows to be displayed on each side
    final rowsPerSide = rows ~/ 2; // Half the number of rows

    final brickSize = Size(wallSize.width / 10.0, wallSize.height / 10.0);
    var brickPosition = Vector2.zero();
    if (rows == 1) {
      brickPosition = Vector2(
        brickSize.width * 3.0 + gap,
        brickSize.height / 2.0 + position.y,
      );
    } else {
      brickPosition = Vector2(
        brickSize.width * 1.0 + gap,
        brickSize.height / 2.0 + position.y,
      );
    }

    Random randomNumRows = Random(10);
    Random randomNumCols = Random();

    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        await add(WallBrick(
          size: brickSize,
          color: (j ~/ 2 == 0)
              ? AppColors.brickColorPrimary
              : AppColors.brickColorSecondary,
          brickPosition: brickPosition,
        ));
        final randomColMulti = randomNumCols.nextInt(1) + 1.3;
        debugPrint(randomColMulti.toString());
        if (rows < 3) {
          brickPosition += Vector2(brickSize.width * 1.0 + gap, 0.0);
        } else {
          brickPosition +=
              Vector2(brickSize.width * randomColMulti.toDouble(), 0.0);
        }
      }
      if (rows < 3) {
        // Calculate the horizontal position for the next row based on the current row
        if (i < rowsPerSide - 1) {
          brickPosition = Vector2(
            brickSize.width / 2.0 + gap,
            brickPosition.y + brickSize.height + gap,
          );
        } else {
          brickPosition = Vector2(
            gameRef.size.x - brickSize.width * (3.5) - gap,
            brickPosition.y + brickSize.height + gap,
          );
        }
      } else {
        final random = randomNumRows.nextDouble() * 2.4;
        debugPrint(random.toString());
        brickPosition += Vector2(
          (brickSize.width * random + gap) - brickPosition.x,
          brickSize.height + gap * random,
        );
      }
    }
  }

  BrickWall copyWith({
    Vector2? position,
    Size? size,
    int? rows,
    int? columns,
    double? gap,
  }) {
    return BrickWall(
        position: position ?? this.position,
        size: size ?? this.size,
        rows: rows ?? this.rows,
        columns: columns ?? this.columns,
        gap: gap ?? this.gap);
  }
}
