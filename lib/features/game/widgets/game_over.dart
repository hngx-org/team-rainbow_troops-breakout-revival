import 'package:brick_breaker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key, required this.isGameOver, required this.onTap});

  final bool isGameOver;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.3),
                child: Text(
                  'G A M E  O V E R',
                  style: GoogleFonts.russoOne(
                    color: AppColors.greenColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                  alignment: const Alignment(0, 0),
                  child: GestureDetector(
                    onTap: onTap,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Ink(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            color: AppColors.brickColorPrimary),
                        child: Text(
                          'Play Again',
                          style: GoogleFonts.russoOne(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greenColor),
                        ),
                      ),
                    ),
                  ))
            ],
          )
        : Container();
  }
}
