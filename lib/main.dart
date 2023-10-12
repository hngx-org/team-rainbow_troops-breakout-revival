import 'package:brick_breaker/features/authentication/viewmodels/authentication_view_model.dart';
import 'package:brick_breaker/features/authentication/views/login_view.dart';
import 'package:brick_breaker/features/authentication/views/signup_view.dart';
import 'package:brick_breaker/utils/widgets/dialog_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'features/authentication/services/dialog_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        builder: (context, child) => Navigator(
          key: DialogService().dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => DialogManager(child: child)),
        ),
        home: SignupView(),
      ),
    );
  }
}
