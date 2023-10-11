import 'package:brick_breaker/utils/constants.dart';
import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  const Player({super.key, required this.playerX, required this.playerWidth});

  final double playerX;
  final double playerWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment:
            Alignment(((2 * playerX + playerWidth) / (2 - playerWidth)), 0.9),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Container(
            height: 10,
            width: MediaQuery.sizeOf(context).width * playerWidth / 2,
            decoration: const BoxDecoration(
              color: AppColors.greenColor,
            ),
          ),
        ));
  }
}
