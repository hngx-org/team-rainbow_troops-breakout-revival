import 'package:brick_breaker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPlay extends StatelessWidget {
  const StartPlay({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.isGameStarted,
  });

  final double width;
  final double height;
  final VoidCallback onTap;
  final bool isGameStarted;

  @override
  Widget build(BuildContext context) {
    return isGameStarted
        ? const SizedBox.shrink()
        : Container(
            alignment: const Alignment(0, -0.2),
            child: InkWell(
              onTap: onTap,
              child: Ink(
                width: width * .3,
                height: height * .06,
                decoration: const BoxDecoration(
                    color: AppColors.brickColorPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    'Play',
                    style: GoogleFonts.russoOne(
                        fontWeight: FontWeight.w400,
                        height: .3,
                        fontSize: 30,
                        color: AppColors.greenColor),
                  ),
                ),
              ),
            ),
          );
  }
}
