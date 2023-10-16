import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image1.png'),
            const SizedBox(height: 16),
             const Text(
              'Breakout',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset('assets/image2.png'),
            const SizedBox(height: 16),
            Image.asset('assets/image3.png'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}