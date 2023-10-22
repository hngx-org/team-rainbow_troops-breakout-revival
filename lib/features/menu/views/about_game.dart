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
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.brickColorPrimary),
          ),
          leading: IconButton(
              onPressed: () {
                navigationService.navigateTo(menu);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.brickColorPrimary,
              )),
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
                  '\n'
                  '\n'
                  'Engage in an addictive gameplay '
                  'experience as you take control '
                  'of the paddle and aim to demolish '
                  'a vibrant array of colorful bricks. '
                  '\n'
                  '\n'
                  'Utilize your reflexes and precision '
                  'to skillfully bounce the ball '
                  'off the paddle, smashing through '
                  'layers of obstacles and unlocking '
                  'exciting power-ups along the way. '
                  '\n'
                  '\n'
                  'With each level presenting new '
                  'challenges and intricately designed '
                  'layouts, immerse yourself in a '
                  'dynamic arcade adventure as you  '
                  'aim for the ultimate high score '
                  '\n'
                  '\nBegin the game by tapping the main button'
                  '\n',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.brickColorPrimary),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    navigationService.navigateTo(menu);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu, color: AppColors.brickColorPrimary),
                      SizedBox(width: 8.0),
                      Text(
                        'Menu',
                        style: TextStyle(
                          color: AppColors.brickColorPrimary,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
