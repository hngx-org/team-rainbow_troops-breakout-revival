import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:brick_breaker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Modal extends StatelessWidget {
  final Forge2dGameWorld game;
  const Modal({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xff3e4c65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: SizedBox(
        width: 317,
        height: 308,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          // color: Colors.white,
          color: const Color(0xff3e4c65),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/star1.svg",
                    width: 75,
                    height: 75,
                  ),
                  SvgPicture.asset(
                    "assets/images/star1.svg",
                    width: 125,
                    height: 125,
                  ),
                  SvgPicture.asset(
                    "assets/images/star2.svg",
                    width: 75,
                    height: 75,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Level ${game.gameLevel.index}",
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFA9B6CE)),
              ),
              const SizedBox(height: 10),
              const Text(
                "COMPLETE",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => game.resetGame(true),
                    icon: const Icon(
                      Icons.replay,
                      size: 50,
                      color: AppColors.brickColorSecondary,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    onPressed: game.moveToNextLevel,
                    icon: const ImageIcon(
                      AssetImage(
                        "assets/images/play.png",
                      ),
                      size: 50,
                      color: AppColors.brickColorSecondary,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
