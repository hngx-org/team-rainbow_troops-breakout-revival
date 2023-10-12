import 'dart:async';

import 'package:brick_breaker/features/game/models/direction_enums.dart';
import 'package:brick_breaker/features/game/widgets/game_over.dart';
import 'package:brick_breaker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/ball.dart';
import '../widgets/player.dart';
import '../widgets/start_play.dart';
import '../widgets/brick.dart';

class GameMainPage extends StatefulWidget {
  const GameMainPage({super.key});

  @override
  State<GameMainPage> createState() => _GameMainPageState();
}

class _GameMainPageState extends State<GameMainPage> {
  ///ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXIncrements = 0.001;
  double ballYIncrements = 0.01;
  var ballXDirection = Direction.LEFT;
  var ballYDirection = Direction.DOWN;

  ///player variables
  double playerX = 0;
  double playerWidth = 0.5;

  ///Brick variables
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.3;
  static double brickHeight = 0.05;
  static int brickCount = 5;
  static double brickGap = 0.01;
  static double wallGap =
      0.5 * (2 - brickCount * brickWidth - (brickCount - 1) * brickGap);

  List bricks = List.generate(brickCount, (i) {
    //[x,y,broken=true/false]
    return [firstBrickX + i * (brickWidth + brickGap), firstBrickY, false];
  });

  /// Game Settings
  bool isGameStarted = false;
  bool isGameOver = false;

  /// Game Start
  void startGame() {
    isGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      //movement
      moveBall();
      //direction
      updateDirection();

      //Check if player dead
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
        score = 0;
      }

      //brick broken
      checkForBrokenBrick();
    });
  }

  //Check if player dead
  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
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
    if (!(playerX + playerWidth >= 1)) {
      playerX += 0.2;
    }
  }

  ///ball direction and movement
  void moveBall() {
    setState(() {
      ///horizontal movement
      if (ballXDirection == Direction.LEFT) {
        if (ballX == 0) {
          ballX -= ballXIncrements;
        } else {
          ballX -= (ballXIncrements += 0.00000001);
        }
      } else if (ballXDirection == Direction.RIGHT) {
        if (ballX == 0) {
          ballX += ballXIncrements;
        } else {
          ballX += (ballXIncrements += 0.0000001);
        }
      }

      ///vertical movement
      if (ballYDirection == Direction.DOWN) {
        ballY += ballYIncrements;
      } else if (ballYDirection == Direction.UP) {
        ballY -= ballYIncrements;
      }
    });
  }

  void updateDirection() {
    setState(() {
      //move up
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = Direction.UP;
        //move down
      } else if (ballY <= -0.9) {
        ballYDirection = Direction.DOWN;
      }
      //move left
      if (ballX >= 1) {
        ballXDirection = Direction.LEFT;
      }
      //move right
      else if (ballX <= -1) {
        ballXDirection = Direction.RIGHT;
      }
    });
  }

  var score = 0;

  ///Check if brick broken
  void checkForBrokenBrick() {
    for (var i = 0; i < bricks.length; i++) {
      if (ballX >= bricks[i][0] &&
          ballX <= bricks[i][0] + brickWidth &&
          ballY <= bricks[i][1] + brickHeight &&
          bricks[i][2] == false) {
        setState(() {
          score += 1;
          bricks[i][2] = true;
          ballYDirection = Direction.DOWN;
        });
      }
    }
  }

  /// Play Again
  void playAgain() {
    setState(() {
      score = 0;
      playerX = -0.2;
      ballX = 0;
      ballY = 0;
      isGameOver = false;
      isGameStarted = false;
      bricks = List.generate(brickCount, (i) {
        //[x,y,broken=true/false]
        return [firstBrickX + i * (brickWidth + brickGap), firstBrickY, false];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: 120,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Score: $score',
              style: GoogleFonts.rubikGemstones(fontSize: 22),
            ),
          ),
        ),
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

              ///Game over
              GameOver(isGameOver: isGameOver, onTap: playAgain),

              Brick(
                brickX: bricks[0][0],
                brickY: bricks[0][1],
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                isBrickBroken: bricks[0][2],
              ),
              Brick(
                brickX: bricks[1][0],
                brickY: bricks[1][1],
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                isBrickBroken: bricks[1][2],
              ),
              Brick(
                brickX: bricks[2][0],
                brickY: bricks[2][1],
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                isBrickBroken: bricks[2][2],
              ),
              Brick(
                brickX: bricks[3][0],
                brickY: bricks[3][1],
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                isBrickBroken: bricks[3][2],
              ),
              Brick(
                brickX: bricks[4][0],
                brickY: bricks[4][1],
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                isBrickBroken: bricks[4][2],
              ),

              ///ball
              Ball(ballX: ballX, ballY: ballY),

              ///player
              Player(playerX: playerX, playerWidth: playerWidth),

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
      ),
    );
  }
}
