import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.svg'),
            const SizedBox(height: 16),
            Image.asset('assets/breakout.png'),
            const SizedBox(height: 16),
            Image.asset('assets/struct.png'),
            const SizedBox(height: 16),
            Image.asset('assets/loading.png'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}