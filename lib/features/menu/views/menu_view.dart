import 'package:brick_breaker/features/services/locator_service.dart';
import 'package:brick_breaker/features/services/navigation_service.dart';
import 'package:brick_breaker/routes/route_names.dart';
import 'package:flutter/material.dart';
import '../viewmodels/menu_view_model.dart';
import '../../../utils/widgets/menu_button.dart';

final NavigationService _navigationService = locator<NavigationService>();

class MenuView extends StatelessWidget {
  final MenuButtonViewModel playButtonViewModel = MenuButtonViewModel(
    title: "Play",
    onPressed: () {
      _navigationService.navigateTo(gamepage);
    },
  );

  final MenuButtonViewModel pauseButtonViewModel = MenuButtonViewModel(
    title: "Settings",
    onPressed: () {},
  );

  final MenuButtonViewModel stopButtonViewModel = MenuButtonViewModel(
    title: "Game Info",
    onPressed: () {
      _navigationService.navigateTo(gameinfo);
    },
  );

  final MenuButtonViewModel restartButtonViewModel = MenuButtonViewModel(
    title: "Game Levels",
    onPressed: () {
      // Handle restart button press logic here
    },
  );

  MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F3B52),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(viewModel: playButtonViewModel),
            const SizedBox(height: 16),
            MenuButton(viewModel: pauseButtonViewModel),
            const SizedBox(height: 16),
            MenuButton(viewModel: stopButtonViewModel),
            const SizedBox(height: 16),
            MenuButton(viewModel: restartButtonViewModel),
          ],
        ),
      ),
    );
  }
}
