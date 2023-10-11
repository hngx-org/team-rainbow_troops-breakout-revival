import 'package:brick_breaker/utils/constants.dart';
import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball({
    super.key,
    required this.ballX,
    required this.ballY,
  });

  final double ballX;
  final double ballY;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: 15,
        width: 15,
        decoration: const BoxDecoration(
          color: AppColors.playerColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
