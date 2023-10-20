import 'package:brick_breaker/features/onboarding/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<SplashViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.handleStartUpLogic();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SplashViewModel splashViewModel = context.watch<SplashViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xff303B52),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/logo.svg'),
            const SizedBox(height: 16),
            Image.asset('assets/images/breakout.png'),
            const SizedBox(height: 16),
            Image.asset('assets/images/struct.png'),
            const SizedBox(height: 16),
            Image.asset('assets/images/loading.png'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
