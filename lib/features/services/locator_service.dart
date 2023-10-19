import 'package:brick_breaker/features/services/auth_service.dart';
import 'package:brick_breaker/features/services/dialog_service.dart';
import 'package:brick_breaker/features/services/firestore_service.dart';
import 'package:brick_breaker/features/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setUpLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FirestoreService());
}
