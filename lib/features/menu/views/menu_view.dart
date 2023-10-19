import 'package:flutter/material.dart';
import '../viewmodels/menu_view_model.dart';
import '../../../utils/widgets/menu_button.dart';

class MenuView extends StatelessWidget {
  final MenuButtonViewModel playButtonViewModel = MenuButtonViewModel(
    title: "Play",
    onPressed: () {
      // Handle play button press logic here
    },
  );

  final MenuButtonViewModel pauseButtonViewModel = MenuButtonViewModel(
    title: "Settings",
    onPressed: () {
      // Handle pause button press logic here
    },
  );

  final MenuButtonViewModel stopButtonViewModel = MenuButtonViewModel(
    title: "Game Info",
    onPressed: () {
      // Handle stop button press logic here
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