import 'package:brick_breaker/features/services/navigation_service.dart';
import 'package:brick_breaker/routes/route_names.dart';
import 'package:flutter/material.dart';

import '../../services/locator_service.dart';

class MenuButtonViewModel extends ChangeNotifier {
  NavigationService _navigationService = locator<NavigationService>();

  final String title;
  final VoidCallback onPressed;

  MenuButtonViewModel({required this.title, required this.onPressed});

  void navigateToGamePage() {
    _navigationService.navigateTo(gamepage);
  }

  void navigateToSettings() {
    _navigationService.navigateTo(gamepage);
  }

  void navigateToGameInfo() {
    _navigationService.navigateTo(gamepage);
  }

  void navigateToGameLevels() {
    _navigationService.navigateTo(gamepage);
  }
}
