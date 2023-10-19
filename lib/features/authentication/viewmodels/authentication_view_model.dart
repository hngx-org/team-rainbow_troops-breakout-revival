import 'package:brick_breaker/features/services/dialog_service.dart';
import 'package:brick_breaker/features/services/locator_service.dart';
import 'package:brick_breaker/features/services/navigation_service.dart';
import 'package:brick_breaker/routes/route_names.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/global.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  bool _isBusy = false;
  bool get busy => _isBusy;

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  snackBar(String title) {
    SnackBar(content: Text(title));
    snackBarKey.currentState?.showSnackBar(snackBar(title));
  }

  Future signUp({
    required String email,
    required String password,
    required String userName,
    required Function? onCallBack,
  }) async {
    setBusy(true);
    var result = await _authenticationService.signUpWithEmail(
        email: email, password: password, userName: userName);
    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(login);
      } else {
        await _dialogService.showDialog(
            title: 'Sign up Failure',
            description: 'General Signup Failure, please try again later');
      }
    } else {
      await _dialogService.showDialog(
        title: 'SignUp Failure',
        description: result,
      );
    }
  }

  Future logIn({String? email, String? password, Function? onCallBack}) async {
    setBusy(true);
    var result = await _authenticationService.loginWithEmail(
        email: email!, password: password!);
    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(gamepage);
      } else {
        await _dialogService.showDialog(
            title: "Login Failed",
            description:
                "Couldn't login at this moment. please try again later");
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }
}
