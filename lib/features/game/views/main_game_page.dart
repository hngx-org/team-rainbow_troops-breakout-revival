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
  // instance of forge2dGameWorld component
  final forge2dGameWorld = Forge2dGameWorld();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        /* centerTitle: true,
        title: Text(
          'Level: ${forge2dGameWorld.gameLevel.name}',
          style: GoogleFonts.mooLahLah(
            fontSize: 28,
            color: AppColors.brickColorSecondary,
            fontWeight: FontWeight.w300,
          ),
        ),
*/
        actions: [
          IconButton(
              onPressed: forge2dGameWorld.pause,
              icon: /* (game.gameState == GameState.running)
                    ? const ImageIcon(
                        AssetImage('assets/images/pause.png'),
                        size: 35,
                        color: AppColors.brickColorSecondary,
                      )
                    :  */
                  const ImageIcon(
                AssetImage('assets/images/play.png'),
                size: 35,
                color: AppColors.brickColorSecondary,
              )),
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: GameWidget(
              game: forge2dGameWorld,
              overlayBuilderMap: const {
                'PreGame': OverlayBuilder.preGame,
                'PostGame': OverlayBuilder.postGame,
                'GameLevel': OverlayBuilder.levelWidget,
              },
            )),
      ),
    );
  }
}
