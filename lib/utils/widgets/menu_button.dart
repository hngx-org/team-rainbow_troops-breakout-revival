import '../../features/menu/viewmodels/menu_view_model.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final MenuButtonViewModel viewModel;

  const MenuButton({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: viewModel.onPressed,
      child: Container(
        width: 208,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.white],
          ),
        ),
        child: Center(
          child: Text(
            viewModel.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
