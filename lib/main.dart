import 'package:brick_breaker/features/authentication/viewmodels/authentication_view_model.dart';
import 'package:brick_breaker/features/onboarding/splash_view_model.dart';
import 'package:brick_breaker/features/services/locator_service.dart';
import 'package:brick_breaker/features/services/navigation_service.dart';
import 'package:brick_breaker/routes/route_names.dart';
import 'package:brick_breaker/utils/dialog/dialog_manager.dart';
// import 'package:brick_breaker/utils/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:brick_breaker/routes/router.dart' as router;
import 'features/services/dialog_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => SplashViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: (context, child) => Navigator(
          key: locator<DialogService>().dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => DialogManager(child: child)),
        ),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.Routes.generateRoute,
        initialRoute: splash,
      ),
      // home: const Modal()
    );
  }
}
