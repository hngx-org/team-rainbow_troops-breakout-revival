import 'package:brick_breaker/features/game/components/forge2d_game_world.dart';
import 'package:brick_breaker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OverlayBuilder {
  OverlayBuilder._();

  static Widget preGame(BuildContext context, Forge2dGameWorld gameWorld) {
    return const PreGameOverlay();
  }

  static Widget postGame(BuildContext context, Forge2dGameWorld gameWorld) {
    assert(gameWorld.gameState == GameState.lost ||
        gameWorld.gameState == GameState.won);

    final message =
        (gameWorld.gameState == GameState.won) ? 'Yay, You won!' : 'Game over';
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

  final String message;
  final Forge2dGameWorld game;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: GoogleFonts.russoOne(
                color: AppColors.greenColor,
                fontSize: 24,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 24,
          ),
          _resetGameButton(context, game),
        ],
      ),
    );
  }
}

Widget _resetGameButton(BuildContext context, Forge2dGameWorld game) {
  return OutlinedButton.icon(
    style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.brickColorPrimary)),
    onPressed: () => game.resetGame(),
    icon: const Icon(Icons.restart_alt_outlined),
    label: const Text('Replay'),
  );
}
