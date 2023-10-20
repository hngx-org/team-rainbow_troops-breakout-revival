import 'package:brick_breaker/features/authentication/views/login_view.dart';
import 'package:brick_breaker/features/authentication/views/signup_view.dart';
import 'package:brick_breaker/features/game/views/main_game_page.dart';
import 'package:brick_breaker/features/menu/views/menu_view.dart';
import 'package:brick_breaker/features/onboarding/splash.dart';
import 'package:brick_breaker/routes/route_names.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case splash:
        page = const SplashScreen();
        break;
      case login:
        page = LoginView();
        break;
      case signup:
        page = SignupView();
        ();
        break;
      case gamepage:
        page = const MainGamePage();
        break;
      case menu:
        page = MenuView();
        break;
      default:
        page = const Center(
          child: Text('No Specified Route'),
        );
    }
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(seconds: 0),
    );
  }
}
