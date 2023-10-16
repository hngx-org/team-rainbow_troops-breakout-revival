import 'package:flutter/material.dart';

class MenuButtonViewModel {
  final String title;
  final VoidCallback onPressed;

  MenuButtonViewModel({required this.title, required this.onPressed});
}
