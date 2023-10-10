import 'dart:async';

import 'package:brick_breaker/features/game/models/direction_enums.dart';
import 'package:brick_breaker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameMainPage extends StatefulWidget {
  const GameMainPage({super.key});

  @override
  State<GameMainPage> createState() => _GameMainPageState();
}

class _GameMainPageState extends State<GameMainPage> {
  ///ball variables
  double ballX = 0;
  double ballY = 0;
  var ballDirection = Direction.DOWN;

  ///player variables
  double playerX = 0;
  double playerWidth = 0.3;

  /// Game Settings
  bool isGameStarted = false;

  /// Game Start
  void startGame() {
    isGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      //movement
      moveBall();
      //direction
      updateDirection();
    });
  }

  /// Player Movement
  /// Move Right
  void moveLeft() {
    if (!(playerX - 0.2 < -1)) {
      playerX -= 0.2;
    }
  }

  /// Move Right
  void moveRight() {
    if (!(playerX + 0.2 > 1)) {
      playerX += 0.2;
    }
  }

  ///ball direction and movement
  void moveBall() {
    setState(() {
      if (ballDirection == Direction.DOWN) {
        ballY += 0.01;
      } else if (ballDirection == Direction.UP) {
        ballY -= 0.01;
      }
    });
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballDirection = Direction.UP;
      } else if (ballY <= -0.9) {
        ballDirection = Direction.DOWN;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Stack(
          children: [
            ///tap to play widget
            StartPlay(
                width: width,
                height: height,
                onTap: startGame,
                isGameStarted: isGameStarted),

            ///player
            Player(playerX: playerX, playerWidth: playerWidth),

            ///ball
            Ball(ballX: ballX, ballY: ballY),
            Positioned(
                left: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: moveLeft,
                  onDoubleTap: moveLeft,
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.sizeOf(context).width * .5,
                    child: const Text('Tap'),
                  ),
                )),
            Positioned(
                right: -120,
                bottom: 0,
                child: GestureDetector(
                  onTap: moveRight,
                  onDoubleTap: moveRight,
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.sizeOf(context).width * .5,
                    child: const Text('Tap'),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class Player extends StatelessWidget {
  const Player({super.key, required this.playerX, required this.playerWidth});

  final double playerX;
  final double playerWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(playerX, 0.9),
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
