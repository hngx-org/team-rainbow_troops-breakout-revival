import 'package:brick_breaker/features/game/UI/overlay_builder.dart';
import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:brick_breaker/utils/constants.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({super.key});

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  final rwGreen = const Color.fromARGB(255, 21, 132, 67);
  // instance of forge2dGameWorld component
  final forge2dGameWorld = Forge2dGameWorld();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
          color: Colors.black87,
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 40,
          ),
          child: GameWidget(
            game: forge2dGameWorld,
            overlayBuilderMap: const {
              'PreGame': OverlayBuilder.preGame,
              'PostGame': OverlayBuilder.postGame,
            },
          )),
    );
  }
}
