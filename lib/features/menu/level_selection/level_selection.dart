import 'package:brick_breaker/features/services/locator_service.dart';
import 'package:brick_breaker/features/services/navigation_service.dart';
import 'package:flutter/material.dart';

class LevelSelectionScreen extends StatelessWidget {
  final List<String> levels = ['Easy', 'Medium', 'Hard'];

  LevelSelectionScreen({super.key}); // List of available levels

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = locator<NavigationService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Level'),
      ),
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(levels[index]),
            onTap: () {
              // _navigationService.navigateTo(); // Navigate to the game screen with the selected level
            },
          );
        },
      ),
    );
  }
}
