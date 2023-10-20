import 'package:brick_breaker/features/services/locator_service.dart';
import 'package:brick_breaker/features/services/navigation_service.dart';
import 'package:brick_breaker/routes/route_names.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class GameInfo extends StatelessWidget {
  const GameInfo({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = locator<NavigationService>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF2F3B52),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'About Game',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: const Icon(Icons.arrow_back_ios),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Column(
              children: [
                const Text(
                  'Embark on an exhilarating journey '
                  'through the captivating world '
                  'of Breakout, where fast-paced '
                  'action and strategic thinking collide. '
                  'Engage in an addictive gameplay '
                  'experience as you take control '
                  'of the paddle and aim to demolish '
                  'a vibrant array of colorful bricks. '
                  'Utilize your reflexes and precision '
                  'to skillfully bounce the ball '
                  'off the paddle, smashing through '
                  'layers of obstacles and unlocking '
                  'exciting power-ups along the way. '
                  'With each level presenting new '
                  'challenges and intricately designed '
                  'layouts, immerse yourself in a '
                  'dynamic arcade adventure as you  '
                  'aim for the ultimate high score '
                  '\n'
                  '\nBegin the game by taping the main button'
                  '\n'
                  // '\nAdjust the speed and size of ball using the settings'
                  '\n',
                  // '\nSelect the game level using the Game levels button',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white24),
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: AppColors.brickColorPrimary)),
                    onPressed: () {
                      navigationService.navigateTo(menu);
                    },
                    child: const Text(
                      'Menu',
                      style: TextStyle(color: AppColors.brickColorPrimary),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
