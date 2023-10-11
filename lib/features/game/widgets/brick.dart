import 'package:brick_breaker/utils/constants.dart';
import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  const Brick({
    super.key,
    required this.brickX,
    required this.brickY,
    required this.brickHeight,
    required this.brickWidth,
    required this.isBrickBroken,
  });

  final double brickX;
  final double brickY;
  final double brickHeight;
  final double brickWidth;
  final bool isBrickBroken;

  @override
  Widget build(BuildContext context) {
    return isBrickBroken
        ? Container()
        : Container(
            alignment:
                Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Container(
                height: MediaQuery.sizeOf(context).height * brickHeight / 2,
                width: MediaQuery.sizeOf(context).width * brickWidth / 2,
                decoration:
                    const BoxDecoration(color: AppColors.brickColorPrimary),
              ),
            ),
          );
  }
}
