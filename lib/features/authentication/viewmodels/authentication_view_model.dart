import 'package:brick_breaker/features/authentication/services/auth_service.dart';
import 'package:brick_breaker/features/authentication/services/dialog_service.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();
  final DialogService _dialogService = DialogService();

  bool _isBusy = false;
  bool get busy => _isBusy;

  BuildContext? context;
  Color? color;
  String? message;

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  Future signUp(
      {String? email, String? password, Function? onCallBack, Bu}) async {
    setBusy(true);
    var result = await _authenticationService.signUpWithEmail(
        email: email!, password: password!);
    setBusy(false);

    if (result is bool) {
      if (result) {
        onCallBack!();
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

  Future login({String? email, String? password, Function? onCallBack}) async {
    setBusy(true);
    var result = await _authenticationService.loginWithEmail(
        email: email!, password: password!);
    setBusy(false);
    if (result is bool) {
      if (result) {
        onCallBack!();
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
