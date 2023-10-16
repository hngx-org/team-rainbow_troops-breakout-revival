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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFB2B6C6).withOpacity(1.0),
              const Color(0xFFEBECF0).withOpacity(1.0),
            ],
          ),
          border: Border.all(
            color: Colors.black.withOpacity(0.35),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 5.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            viewModel.title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
