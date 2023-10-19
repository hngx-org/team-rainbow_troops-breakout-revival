import 'package:brick_breaker/features/services/auth_service.dart';
import 'package:brick_breaker/features/services/locator_service.dart';
import 'package:brick_breaker/features/services/navigation_service.dart';
import 'package:brick_breaker/routes/route_names.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(login);
    } else {
      _navigationService.navigateTo(signup);
    }
  }
}
