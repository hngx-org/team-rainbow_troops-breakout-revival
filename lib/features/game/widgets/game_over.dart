import 'package:brick_breaker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key, required this.isGameOver});

  final bool isGameOver;

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Container(
            alignment: const Alignment(0, -0.3),
            child: Text(
              'G A M E  O V E R',
              style: GoogleFonts.russoOne(
                color: AppColors.greenColor,
                fontWeight: FontWeight.w400,
                fontSize: 30,
              ),
            ),
          )
        : Container();
  }
}
