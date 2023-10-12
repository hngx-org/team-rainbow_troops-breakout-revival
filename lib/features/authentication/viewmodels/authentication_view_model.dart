import 'package:brick_breaker/features/authentication/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:brick_breaker/features/authentication/services/global.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();

  bool _isBusy = false;
  bool get busy => _isBusy;

  BuildContext? context;
  Color? color;
  String? message;

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  snackBar(String title) {
    SnackBar(content: Text(title));
    snackBarKey.currentState?.showSnackBar(snackBar(title));
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
        snackBar('General Signup Failure, please try again later');
      }
    } else {
      snackBar(result);
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
        snackBar("Couldn't login at this moment. please try again later");
      }
    } else {
      snackBar(result);
    }
  }
}
