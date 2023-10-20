import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:brick_breaker/features/game/constants.dart';
import 'package:brick_breaker/features/services/locator_service.dart';
import 'package:brick_breaker/features/services/navigation_service.dart';
import 'package:brick_breaker/utils/constants.dart';
import 'package:brick_breaker/utils/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/route_names.dart';

NavigationService _navigationService = locator<NavigationService>();

class OverlayBuilder {
  OverlayBuilder._();

  static Widget preGame(BuildContext context, Forge2dGameWorld gameWorld) {
    return const PreGameOverlay();
  }

  static Widget levelWidget(BuildContext context, Forge2dGameWorld gameWorld) {
    return GameLevelWidget(game: gameWorld);
  }

  static Widget postGame(BuildContext context, Forge2dGameWorld gameWorld) {
    assert(gameWorld.gameState == GameState.lost ||
        gameWorld.gameState == GameState.won);

    debugPrint(gameWorld.gameState.toString());

    final message = (gameWorld.gameState == GameState.won)
        ? const Modal()
        : const Text('Game over');
    return PostGameOverlay(message: message, game: gameWorld);
  }
}

class PreGameOverlay extends StatelessWidget {
  const PreGameOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tap Paddle to Begin',
        style: GoogleFonts.russoOne(
            color: AppColors.greenColor,
            fontSize: 24,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class PostGameOverlay extends StatelessWidget {
  const PostGameOverlay({super.key, required this.message, required this.game});

  final dynamic message;
  final Forge2dGameWorld game;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(
            builder: (BuildContext context) {
              if (message is String) {
                // If message is a String, create a Text widget
                return Text(
                  message,
                  style: GoogleFonts.russoOne(
                      color: AppColors.greenColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                );
              } else if (message is Widget) {
                // If message is a Widget, return it directly
                return message;
              } else {
                // Handle other types of messages if needed
                return Container();
              }
            },
          ),
          const SizedBox(
            height: 24,
          ),
          _resetGameButton(context, game),
          SizedBox(
            height: 24,
          ),
          OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.brickColorPrimary)),
              onPressed: () {
                _navigationService.navigateTo(menu);
              },
              icon: SvgPicture.asset(
                'assets/images/menu.svg',
                width: 24,
                height: 20,
                color: Colors.purple,
              ),
              label: Text(
                'Menu',
                style: TextStyle(color: Colors.purple),
              ))
        ],
      ),
    );
  }
}

Widget _resetGameButton(BuildContext context, Forge2dGameWorld game) {
  return OutlinedButton.icon(
    style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.brickColorPrimary)),
    onPressed: () => (game.gameState == GameState.lost)
        ? game.resetGame()
        : game.moveToNextLevel(),
    icon: (game.gameState == GameState.lost)
        ? SvgPicture.asset(
            'assets/images/Replay.svg',
            width: 24,
            height: 24,
            color: Colors.purple,
          )
        : SvgPicture.asset(
            'assets/images/play_arrow.svg',
            width: 24,
            height: 24,
            color: Colors.purple,
          ),
    label: (game.gameState == GameState.lost)
        ? const Text(
            'Replay',
            style: TextStyle(color: Colors.purple),
          )
        : const Text(
            'Play next level',
            style: TextStyle(color: Colors.purple),
          ),
  );
}

class GameLevelWidget extends StatelessWidget {
  const GameLevelWidget({super.key, required this.game});
  final Forge2dGameWorld game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: const Alignment(0.0, -0.95),
            child: Text(
              'Level: ${game.gameLevel.index + 1}',
              style: GoogleFonts.mooLahLah(
                fontSize: 28,
                color: AppColors.brickColorSecondary,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, -0.97),
            child: IconButton(
                onPressed: game.pause,
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
          )
        ],
      ),
    );
  }
}
